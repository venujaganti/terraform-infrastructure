resource "terraform_data" "network_policy" {
  input = local.policy_summary

  lifecycle {
    precondition {
      condition = (
        !var.allow_public_ssh ||
        contains(var.allowed_ingress_ports, 22)
      )

      error_message = "SSH cannot be marked as publicly allowed unless port 22 is included in allowed_ingress_ports."
    }

    precondition {
      condition = (
        !var.allow_public_http_https ||
        (
          contains(var.allowed_ingress_ports, 80) &&
          contains(var.allowed_ingress_ports, 443)
        )
      )

      error_message = "Public HTTP/HTTPS requires ports 80 and 443 in allowed_ingress_ports."
    }
  }
}