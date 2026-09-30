output "application_log_group_name" {
  description = "Application CloudWatch log group name."
  value       = try(aws_cloudwatch_log_group.application[0].name, null)
}

output "application_log_group_arn" {
  description = "Application CloudWatch log group ARN."
  value       = try(aws_cloudwatch_log_group.application[0].arn, null)
}

output "system_log_group_name" {
  description = "System CloudWatch log group name."
  value       = try(aws_cloudwatch_log_group.system[0].name, null)
}

output "system_log_group_arn" {
  description = "System CloudWatch log group ARN."
  value       = try(aws_cloudwatch_log_group.system[0].arn, null)
}

output "audit_log_group_name" {
  description = "Audit CloudWatch log group name."
  value       = try(aws_cloudwatch_log_group.audit[0].name, null)
}

output "audit_log_group_arn" {
  description = "Audit CloudWatch log group ARN."
  value       = try(aws_cloudwatch_log_group.audit[0].arn, null)
}