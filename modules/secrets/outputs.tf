output "secret_id" {
  description = "Secrets Manager secret ID."
  value       = aws_secretsmanager_secret.this.id
}

output "secret_arn" {
  description = "Secrets Manager secret ARN."
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Secrets Manager secret name."
  value       = aws_secretsmanager_secret.this.name
}

output "secret_version_id" {
  description = "Current Terraform-managed secret version ID."
  value       = try(aws_secretsmanager_secret_version.this[0].version_id, null)
}