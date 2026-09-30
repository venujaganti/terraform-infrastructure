data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"

      identifiers = [
        "backup.amazonaws.com"
      ]
    }
  }
}

resource "aws_backup_vault" "this" {
  name = local.backup_vault_name

  tags = merge(
    local.common_tags,
    {
      Name = local.backup_vault_name
      Type = "backup-vault"
    }
  )
}

resource "aws_backup_vault_lock_configuration" "this" {
  count = var.enable_vault_lock ? 1 : 0

  backup_vault_name = aws_backup_vault.this.name

  min_retention_days = var.vault_lock_min_retention_days
  max_retention_days = var.vault_lock_max_retention_days

  lifecycle {
    precondition {
      condition = (
        var.vault_lock_max_retention_days >=
        var.vault_lock_min_retention_days
      )

      error_message = "vault_lock_max_retention_days must be greater than or equal to vault_lock_min_retention_days."
    }
  }
}

resource "aws_iam_role" "backup" {
  name = local.backup_role_name

  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = local.backup_role_name
      Type = "backup-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "backup" {
  role = aws_iam_role.backup.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_plan" "this" {
  name = local.backup_plan_name

  rule {
    rule_name         = local.backup_rule_name
    target_vault_name = aws_backup_vault.this.name

    schedule = var.schedule

    start_window      = var.start_window_minutes
    completion_window = var.completion_window_minutes

    lifecycle {
      cold_storage_after = var.cold_storage_after_days
      delete_after       = var.delete_after_days
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.backup_plan_name
      Type = "backup-plan"
    }
  )

  lifecycle {
    precondition {
      condition = (
        var.delete_after_days >
        var.cold_storage_after_days
      )

      error_message = "delete_after_days must be greater than cold_storage_after_days."
    }
  }
}

resource "aws_backup_selection" "this" {
  count = var.create_backup_selection ? 1 : 0

  name = local.backup_selection_name

  plan_id = aws_backup_plan.this.id

  iam_role_arn = aws_iam_role.backup.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.selection_tag_key
    value = var.selection_tag_value
  }

  depends_on = [
    aws_iam_role_policy_attachment.backup
  ]
}