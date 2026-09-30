locals {
  name_prefix = "${var.project_name}-${var.environment}"

  iam_policy_summary = {
    wildcard_actions_allowed = var.allow_wildcard_actions
    allowed_services         = sort(tolist(var.allowed_services))
  }
}