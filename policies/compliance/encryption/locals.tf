locals {
  name_prefix = "${var.project_name}-${var.environment}"

  required_resources = toset(var.encrypted_resources)
}