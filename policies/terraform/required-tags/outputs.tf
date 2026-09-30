output "required_tags" {
  description = "Required Terraform tags."
  value       = local.normalized_tags
}

output "required_tag_keys" {
  description = "Required Terraform tag keys."
  value       = sort(keys(local.normalized_tags))
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.required_tags_policy.id
}