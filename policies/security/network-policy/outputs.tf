output "policy_name" {
  description = "Network policy name."
  value       = "${local.name_prefix}-network-policy"
}

output "allowed_ingress_ports" {
  description = "Approved inbound ports."
  value       = var.allowed_ingress_ports
}

output "public_ports" {
  description = "Ports allowed for public HTTP/HTTPS traffic."
  value       = local.public_ports
}

output "restricted_ports" {
  description = "Ports requiring restricted access."
  value       = local.restricted_ports
}

output "policy_validation_id" {
  description = "Terraform validation resource ID."
  value       = terraform_data.network_policy.id
}