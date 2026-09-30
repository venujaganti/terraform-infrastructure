output "function_id" {
  description = "ID of the Lambda function."
  value       = aws_lambda_function.this.id
}

output "function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "Invoke ARN of the Lambda function."
  value       = aws_lambda_function.this.invoke_arn
}

output "function_version" {
  description = "Published version of the Lambda function."
  value       = aws_lambda_function.this.version
}

output "role_name" {
  description = "Lambda execution IAM role name."
  value       = aws_iam_role.lambda.name
}

output "role_arn" {
  description = "Lambda execution IAM role ARN."
  value       = aws_iam_role.lambda.arn
}

output "log_group_name" {
  description = "CloudWatch Logs group for the Lambda function."
  value       = aws_cloudwatch_log_group.lambda.name
}