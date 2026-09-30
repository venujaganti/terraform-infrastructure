output "policy_name" {
  description = "IAM governance policy name."
  value       = "${local.name_prefix}-iam-policy"
}

output "allowed_services" {
  description = "Approved AWS services."
  value       = var.allowed_services
}

output "wildcard_actions_allowed" {
  description = "Whether wildcard IAM actions are allowed."
  value       = var.allow_wildcard_actions
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.iam_policy.id
}