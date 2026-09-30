resource "aws_route53_zone" "this" {
  count = var.create_hosted_zone ? 1 : 0

  name = local.zone_name

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-hosted-zone"
    }
  )
}

locals {
  zone_id = var.create_hosted_zone ? aws_route53_zone.this[0].zone_id : var.hosted_zone_id
}

resource "aws_route53_record" "alias_a" {
  count = var.create_alias_record ? 1 : 0

  zone_id = local.zone_id
  name    = var.record_name == null ? local.normalized_domain : var.record_name
  type    = "A"

  alias {
    name                   = var.alias_target_dns_name
    zone_id                = var.alias_target_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    precondition {
      condition = (
        local.zone_id != null &&
        trimspace(local.zone_id) != "" &&
        var.alias_target_dns_name != null &&
        trimspace(var.alias_target_dns_name) != "" &&
        var.alias_target_zone_id != null &&
        trimspace(var.alias_target_zone_id) != ""
      )

      error_message = "A hosted zone ID, alias target DNS name, and alias target zone ID are required when create_alias_record is true."
    }
  }
}

resource "aws_route53_record" "alias_aaaa" {
  count = var.create_alias_record && var.enable_ipv6_record ? 1 : 0

  zone_id = local.zone_id
  name    = var.record_name == null ? local.normalized_domain : var.record_name
  type    = "AAAA"

  alias {
    name                   = var.alias_target_dns_name
    zone_id                = var.alias_target_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    precondition {
      condition = (
        local.zone_id != null &&
        trimspace(local.zone_id) != "" &&
        var.alias_target_dns_name != null &&
        trimspace(var.alias_target_dns_name) != "" &&
        var.alias_target_zone_id != null &&
        trimspace(var.alias_target_zone_id) != ""
      )

      error_message = "A hosted zone ID, alias target DNS name, and alias target zone ID are required when the IPv6 alias record is enabled."
    }
  }
}