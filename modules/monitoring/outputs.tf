output "aws_region" {
  description = "AWS region where monitoring resources are managed."
  value       = data.aws_region.current.name
}

output "aws_account_id" {
  description = "AWS account ID."
  value       = data.aws_caller_identity.current.account_id
}

output "cpu_alarm_id" {
  description = "ID of the EC2 CPU alarm."
  value       = try(aws_cloudwatch_metric_alarm.ec2_cpu_high[0].id, null)
}

output "cpu_alarm_arn" {
  description = "ARN of the EC2 CPU alarm."
  value       = try(aws_cloudwatch_metric_alarm.ec2_cpu_high[0].arn, null)
}

output "cpu_alarm_name" {
  description = "Name of the EC2 CPU alarm."
  value       = try(aws_cloudwatch_metric_alarm.ec2_cpu_high[0].alarm_name, null)
}

output "cpu_alarm_enabled" {
  description = "Whether the EC2 CPU alarm was created."
  value = (
    var.create_cpu_alarm &&
    var.alarm_instance_id != null
  )
}