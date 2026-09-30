locals {
  name_prefix = "${var.project_name}-${var.environment}"

  required_tag_set = toset(var.required_tags)
}