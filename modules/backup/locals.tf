locals {
  name_prefix = "${var.project_name}-${var.environment}"

  backup_vault_name = coalesce(
    var.backup_vault_name,
    "${local.name_prefix}-backup-vault"
  )

  backup_plan_name = coalesce(
    var.backup_plan_name,
    "${local.name_prefix}-backup-plan"
  )

  backup_rule_name = coalesce(
    var.backup_rule_name,
    "${local.name_prefix}-daily-backup"
  )

  backup_role_name = "${local.name_prefix}-backup-role"

  backup_selection_name = "${local.name_prefix}-backup-selection"

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "backup"
    },
    var.tags
  )
}