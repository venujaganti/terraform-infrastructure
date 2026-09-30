output "hosted_zone_id" {
  description = "Route 53 hosted zone ID."
  value       = local.zone_id
}

output "hosted_zone_name" {
  description = "Route 53 hosted zone name."
  value       = local.zone_name
}

output "name_servers" {
  description = "Name servers assigned to the hosted zone."
  value = var.create_hosted_zone ? aws_route53_zone.this[0].name_servers : []
}

output "record_name" {
  description = "DNS record name."
  value       = local.record_name
}

output "alias_a_record_fqdn" {
  description = "FQDN of the Route 53 A alias record."
  value       = try(aws_route53_record.alias_a[0].fqdn, null)
}

output "alias_aaaa_record_fqdn" {
  description = "FQDN of the Route 53 AAAA alias record."
  value       = try(aws_route53_record.alias_aaaa[0].fqdn, null)
}