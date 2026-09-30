locals {
  name_prefix = "${var.project_name}-${var.environment}"

  normalized_domain = trimsuffix(
    trimspace(var.domain_name),
    "."
  )

  zone_name = "${local.normalized_domain}."

  record_name = coalesce(
    var.record_name,
    local.normalized_domain
  )

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "dns"
    },
    var.tags
  )
}