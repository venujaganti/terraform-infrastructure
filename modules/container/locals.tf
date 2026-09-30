locals {
  name_prefix = "${var.project_name}-${var.environment}"

  repository_name = coalesce(
    var.repository_name,
    "${var.project_name}/${var.environment}"
  )

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "container"
  }
}