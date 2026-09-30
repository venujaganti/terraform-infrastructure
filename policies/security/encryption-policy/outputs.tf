output "policy_name" {
  description = "Encryption policy name."
  value       = "${local.name_prefix}-encryption-policy"
}

output "encryption_requirements" {
  description = "Encryption requirements."
  value       = local.encryption_requirements
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.encryption_policy.id
}