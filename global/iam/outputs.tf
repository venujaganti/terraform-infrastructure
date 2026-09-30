output "role_id" {
  description = "ID of the global IAM role."
  value       = aws_iam_role.global.id
}

output "role_name" {
  description = "Name of the global IAM role."
  value       = aws_iam_role.global.name
}

output "role_arn" {
  description = "ARN of the global IAM role."
  value       = aws_iam_role.global.arn
}

output "instance_profile_id" {
  description = "ID of the EC2 instance profile."
  value       = var.create_instance_profile ? aws_iam_instance_profile.global[0].id : null
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile."
  value       = var.create_instance_profile ? aws_iam_instance_profile.global[0].name : null
}

output "instance_profile_arn" {
  description = "ARN of the EC2 instance profile."
  value       = var.create_instance_profile ? aws_iam_instance_profile.global[0].arn : null
}

output "account_id" {
  description = "AWS account ID where the IAM resources are created."
  value       = data.aws_caller_identity.current.account_id
}