data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms" {
  statement {
    sid    = "EnableAccountRootPermissions"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }
}

resource "aws_kms_key" "global" {
  description = var.key_description

  enable_key_rotation = var.enable_key_rotation

  deletion_window_in_days = var.deletion_window_in_days

  policy = data.aws_iam_policy_document.kms.json

  tags = merge(
    {
      Name      = var.key_alias
      ManagedBy = "Terraform"
      Module    = "global-security"
    },
    var.tags
  )
}

resource "aws_kms_alias" "global" {
  name = var.key_alias

  target_key_id = aws_kms_key.global.key_id
}