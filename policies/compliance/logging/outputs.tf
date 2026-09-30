output "policy_name" {
  description = "Logging compliance policy name."
  value       = "${local.name_prefix}-logging-policy"
}

output "required_logging_services" {
  description = "Services requiring logging."
  value       = local.logging_requirements.services
}

output "log_retention_days" {
  description = "Required log retention period."
  value       = local.logging_requirements.retention_days
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.logging_policy.id
}