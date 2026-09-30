output "terraform_constraint" {
  description = "Required Terraform version constraint."
  value       = local.terraform_constraint
}

output "aws_provider_constraint" {
  description = "Required AWS provider constraint."
  value       = local.provider_constraints.aws
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.required_providers_policy.id
}