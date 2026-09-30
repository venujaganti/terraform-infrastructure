output "db_instance_id" {
  description = "ID of the RDS database instance."
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "ARN of the RDS database instance."
  value       = aws_db_instance.this.arn
}

output "db_instance_identifier" {
  description = "Identifier of the RDS database instance."
  value       = aws_db_instance.this.identifier
}

output "db_endpoint" {
  description = "DNS endpoint of the RDS database."
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "Hostname of the RDS database."
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "Port of the RDS database."
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Name of the application database."
  value       = aws_db_instance.this.db_name
}

output "db_username" {
  description = "Master username of the RDS database."
  value       = aws_db_instance.this.username
}

output "db_subnet_group_name" {
  description = "Name of the RDS subnet group."
  value       = aws_db_subnet_group.this.name
}

output "master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the RDS master credentials."
  value       = aws_db_instance.this.master_user_secret[0].secret_arn
}