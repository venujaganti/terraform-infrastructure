output "kms_key_id" {
  description = "ID of the global KMS key."
  value       = aws_kms_key.global.key_id
}

output "kms_key_arn" {
  description = "ARN of the global KMS key."
  value       = aws_kms_key.global.arn
}

output "kms_key_alias" {
  description = "Alias of the global KMS key."
  value       = aws_kms_alias.global.name
}

output "kms_key_alias_arn" {
  description = "ARN of the global KMS key alias."
  value       = aws_kms_alias.global.arn
}

output "account_id" {
  description = "AWS account ID where the KMS key is created."
  value       = data.aws_caller_identity.current.account_id
}