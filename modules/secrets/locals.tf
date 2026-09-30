locals {
  name_prefix = "${var.project_name}-${var.environment}"

  secret_name = coalesce(
    var.secret_name,
    "${local.name_prefix}/application"
  )

  secret_string = (
    length(var.secret_values) > 0
    ? jsonencode(var.secret_values)
    : var.secret_value
  )

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "secrets"
    },
    var.tags
  )
}