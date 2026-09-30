locals {
  name_prefix = "${var.project_name}-${var.environment}"

  lambda_function_name = coalesce(
    var.function_name,
    "${local.name_prefix}-lambda"
  )

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "serverless"
  }
}