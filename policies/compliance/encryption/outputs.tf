output "policy_name" {
  description = "Encryption compliance policy name."
  value       = "${local.name_prefix}-encryption-compliance"
}

output "encrypted_resources" {
  description = "Resource types requiring encryption."
  value       = sort(tolist(local.required_resources))
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.encryption_compliance.id
}