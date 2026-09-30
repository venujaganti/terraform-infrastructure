locals {
  name_prefix = "${var.project_name}-${var.environment}"

  cpu_alarm_name = "${local.name_prefix}-ec2-cpu-high"

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "monitoring"
    },
    var.tags
  )
}