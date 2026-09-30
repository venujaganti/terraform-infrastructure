data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "${local.name_prefix}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-lambda-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${local.lambda_function_name}"
  retention_in_days = var.log_retention_days

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-lambda-logs"
    }
  )
}

resource "aws_lambda_function" "this" {
  function_name = local.lambda_function_name

  role    = aws_iam_role.lambda.arn
  runtime = var.runtime
  handler = var.handler

  filename         = var.lambda_package_path
  source_code_hash = filebase64sha256(var.lambda_package_path)

  memory_size = var.memory_size
  timeout     = var.timeout

  architectures = var.architectures

  reserved_concurrent_executions = var.reserved_concurrency

  environment {
    variables = var.environment_variables
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_cloudwatch_log_group.lambda
  ]

  tags = merge(
    local.common_tags,
    {
      Name = local.lambda_function_name
    }
  )
}