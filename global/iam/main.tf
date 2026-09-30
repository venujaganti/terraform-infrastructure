data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    sid    = "EC2AssumeRole"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "global" {
  name = var.role_name

  description = var.role_description

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  max_session_duration = var.max_session_duration

  tags = merge(
    {
      Name      = var.role_name
      ManagedBy = "Terraform"
      Module    = "global-iam"
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.global.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "global" {
  count = var.create_instance_profile ? 1 : 0

  name = var.instance_profile_name != null ? var.instance_profile_name : "${var.role_name}-profile"

  role = aws_iam_role.global.name

  tags = merge(
    {
      Name      = var.instance_profile_name != null ? var.instance_profile_name : "${var.role_name}-profile"
      ManagedBy = "Terraform"
      Module    = "global-iam"
    },
    var.tags
  )
}