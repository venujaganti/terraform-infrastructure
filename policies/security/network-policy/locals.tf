locals {
  name_prefix = "${var.project_name}-${var.environment}"

  public_ports = [
    for port in var.allowed_ingress_ports :
    port
    if port == 80 || port == 443
  ]

  restricted_ports = [
    for port in var.allowed_ingress_ports :
    port
    if port != 80 && port != 443
  ]

  policy_summary = {
    project             = var.project_name
    environment         = var.environment
    public_http_https   = var.allow_public_http_https
    public_ssh          = var.allow_public_ssh
    approved_port_count = length(var.allowed_ingress_ports)
  }
}