output "hosted_zone_id" {
  description = "Route 53 hosted zone ID."
  value       = aws_route53_zone.global.zone_id
}

output "hosted_zone_name" {
  description = "Route 53 hosted zone name."
  value       = aws_route53_zone.global.name
}

output "hosted_zone_arn" {
  description = "Route 53 hosted zone ARN."
  value       = aws_route53_zone.global.arn
}

output "name_servers" {
  description = "Route 53 name servers for the hosted zone."
  value       = aws_route53_zone.global.name_servers
}

output "verification_record_fqdn" {
  description = "FQDN of the optional verification record."
  value       = var.create_verification_record ? aws_route53_record.verification[0].fqdn : null
}

output "account_id" {
  description = "AWS account ID where the hosted zone is managed."
  value       = data.aws_caller_identity.current.account_id
}