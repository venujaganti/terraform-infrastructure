resource "aws_cloudfront_distribution" "this" {
  enabled         = var.enabled
  is_ipv6_enabled = var.ipv6_enabled

  comment = "${local.name_prefix} CloudFront distribution"

  default_root_object = var.default_root_object

  price_class = var.price_class

  aliases = var.aliases

  origin {
    domain_name = var.origin_domain_name
    origin_id   = local.origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = var.origin_protocol_policy

      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id = local.origin_id

    viewer_protocol_policy = var.viewer_protocol_policy

    allowed_methods = var.allowed_methods
    cached_methods  = var.cached_methods

    compress = var.compress

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = !local.use_custom_certificate

    acm_certificate_arn = local.use_custom_certificate ? var.acm_certificate_arn : null

    ssl_support_method = local.use_custom_certificate ? "sni-only" : null

    minimum_protocol_version = local.use_custom_certificate ? var.minimum_protocol_version : null
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_responses

    content {
      error_code            = custom_error_response.value.error_code
      response_code         = try(custom_error_response.value.response_code, null)
      response_page_path    = try(custom_error_response.value.response_page_path, null)
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-cloudfront"
    }
  )

  lifecycle {
    precondition {
      condition = (
        length(var.aliases) == 0 ||
        (
          var.acm_certificate_arn != null &&
          trimspace(var.acm_certificate_arn) != ""
        )
      )

      error_message = "acm_certificate_arn is required when aliases are configured."
    }
  }
}