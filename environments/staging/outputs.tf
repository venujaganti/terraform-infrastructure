output "environment" {
  description = "Current Terraform environment."
  value       = var.environment
}

output "aws_region" {
  description = "Configured AWS region."
  value       = var.aws_region
}

output "aws_account_id" {
  description = "AWS account ID used by the provider."
  value       = data.aws_caller_identity.current.account_id
}

output "common_tags" {
  description = "Common tags applied by the AWS provider."
  value       = local.common_tags
}