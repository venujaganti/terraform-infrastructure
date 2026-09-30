locals {
  name_prefix = "${var.project_name}-${var.environment}"

  application_log_group_name = coalesce(
    var.application_log_group_name,
    "/${var.project_name}/${var.environment}/application"
  )

  system_log_group_name = coalesce(
    var.system_log_group_name,
    "/${var.project_name}/${var.environment}/system"
  )

  audit_log_group_name = coalesce(
    var.audit_log_group_name,
    "/${var.project_name}/${var.environment}/audit"
  )

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "logging"
    },
    var.tags
  )
}