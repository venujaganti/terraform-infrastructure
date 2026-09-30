locals {
  name_prefix = "${var.project_name}-${var.environment}"

  api_name = coalesce(
    var.api_name,
    "${local.name_prefix}-api"
  )

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "api-gateway"
  }
}