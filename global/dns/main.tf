data "aws_caller_identity" "current" {}

resource "aws_route53_zone" "global" {
  name = var.domain_name

  comment = var.comment

  force_destroy = var.force_destroy

  tags = merge(
    {
      Name      = var.domain_name
      ManagedBy = "Terraform"
      Module    = "global-dns"
    },
    var.tags
  )
}

resource "aws_route53_record" "verification" {
  count = var.create_verification_record ? 1 : 0

  zone_id = aws_route53_zone.global.zone_id
  name    = var.verification_record_name
  type    = "TXT"
  ttl     = 300

  records = [
    var.verification_record_value
  ]
}