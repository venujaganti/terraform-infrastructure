output "policy_name" {
  description = "Tagging policy name."
  value       = "${local.name_prefix}-tagging-policy"
}

output "required_tags" {
  description = "Required resource tags."
  value       = sort(tolist(local.required_tag_set))
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.tagging_policy.id
}