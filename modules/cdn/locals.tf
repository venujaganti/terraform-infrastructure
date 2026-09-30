locals {
  name_prefix = "${var.project_name}-${var.environment}"

  origin_id = coalesce(
    var.origin_id,
    "${local.name_prefix}-origin"
  )

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "cdn"
    },
    var.tags
  )

  use_custom_certificate = length(var.aliases) > 0
}