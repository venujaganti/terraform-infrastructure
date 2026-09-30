output "queue_id" {
  description = "ID of the main SQS queue."
  value       = aws_sqs_queue.this.id
}

output "queue_name" {
  description = "Name of the main SQS queue."
  value       = aws_sqs_queue.this.name
}

output "queue_arn" {
  description = "ARN of the main SQS queue."
  value       = aws_sqs_queue.this.arn
}

output "queue_url" {
  description = "URL of the main SQS queue."
  value       = aws_sqs_queue.this.url
}

output "dlq_id" {
  description = "ID of the dead-letter queue."
  value       = aws_sqs_queue.dlq.id
}

output "dlq_name" {
  description = "Name of the dead-letter queue."
  value       = aws_sqs_queue.dlq.name
}

output "dlq_arn" {
  description = "ARN of the dead-letter queue."
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_url" {
  description = "URL of the dead-letter queue."
  value       = aws_sqs_queue.dlq.url
}