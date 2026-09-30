locals {
  name_prefix = "${var.project_name}-${var.environment}"

  logging_requirements = {
    services = sort(tolist(var.required_logging_services))
    retention_days = var.log_retention_days
  }
}