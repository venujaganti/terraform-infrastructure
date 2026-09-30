resource "aws_sqs_queue" "dlq" {
  name = local.dlq_name

  fifo_queue = var.fifo_queue

  content_based_deduplication = var.fifo_queue ? var.content_based_deduplication : false

  message_retention_seconds = var.message_retention_seconds

  sqs_managed_sse_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name = local.dlq_name
      Type = "dead-letter"
    }
  )
}

resource "aws_sqs_queue" "this" {
  name = local.queue_name

  fifo_queue = var.fifo_queue

  content_based_deduplication = var.fifo_queue ? var.content_based_deduplication : false

  visibility_timeout_seconds = var.visibility_timeout_seconds

  message_retention_seconds = var.message_retention_seconds

  receive_wait_time_seconds = var.receive_wait_time_seconds

  sqs_managed_sse_enabled = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })

  tags = merge(
    local.common_tags,
    {
      Name = local.queue_name
      Type = "main"
    }
  )
}

data "aws_iam_policy_document" "queue" {
  statement {
    sid    = "DenyUnsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "sqs:*"
    ]

    resources = [
      aws_sqs_queue.this.arn
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false"
      ]
    }
  }
}

resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.url
  policy    = data.aws_iam_policy_document.queue.json
}