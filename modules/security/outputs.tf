output "security_group_id" {
  description = "ID of the main security group."
  value       = aws_security_group.main.id
}

output "security_group_name" {
  description = "Name of the main security group."
  value       = aws_security_group.main.name
}

output "vpc_id" {
  description = "VPC ID associated with the security group."
  value       = aws_security_group.main.vpc_id
}