variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string

  validation {
    condition     = trimspace(var.project_name) != ""
    error_message = "project_name must not be empty."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "environment must be dev, staging, or production."
  }
}

variable "origin_domain_name" {
  description = "DNS name of the application origin. Do not include http:// or https://."
  type        = string

  validation {
    condition = (
      !can(regex("^https?://", var.origin_domain_name)) &&
      trimspace(var.origin_domain_name) != ""
    )
    error_message = "origin_domain_name must be a hostname without http:// or https://."
  }
}

variable "origin_id" {
  description = "Optional CloudFront origin ID."
  type        = string
  default     = null
}

variable "aliases" {
  description = "Optional custom domain names for CloudFront."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for alias in var.aliases :
      can(regex("^[A-Za-z0-9*.-]+$", alias))
    ])
    error_message = "Each CloudFront alias must be a valid DNS-style hostname."
  }
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront custom domains."
  type        = string
  default     = null
}

variable "minimum_protocol_version" {
  description = "Minimum TLS protocol version for viewers."
  type        = string
  default     = "TLSv1.2_2021"
}

variable "price_class" {
  description = "CloudFront price class."
  type        = string
  default     = "PriceClass_100"

  validation {
    condition = contains(
      [
        "PriceClass_100",
        "PriceClass_200",
        "PriceClass_All"
      ],
      var.price_class
    )

    error_message = "price_class must be PriceClass_100, PriceClass_200, or PriceClass_All."
  }
}

variable "enabled" {
  description = "Whether the CloudFront distribution is enabled."
  type        = bool
  default     = true
}

variable "ipv6_enabled" {
  description = "Whether IPv6 is enabled."
  type        = bool
  default     = true
}

variable "compress" {
  description = "Whether CloudFront should compress supported objects."
  type        = bool
  default     = true
}

variable "default_root_object" {
  description = "Default object served for the root URL."
  type        = string
  default     = "index.html"
}

variable "origin_protocol_policy" {
  description = "Protocol CloudFront uses to communicate with the origin."
  type        = string
  default     = "https-only"

  validation {
    condition = contains(
      [
        "http-only",
        "https-only",
        "match-viewer"
      ],
      var.origin_protocol_policy
    )

    error_message = "origin_protocol_policy must be http-only, https-only, or match-viewer."
  }
}

variable "allowed_methods" {
  description = "HTTP methods CloudFront accepts."
  type        = list(string)
  default = [
    "GET",
    "HEAD"
  ]
}

variable "cached_methods" {
  description = "HTTP methods CloudFront caches."
  type        = list(string)
  default = [
    "GET",
    "HEAD"
  ]
}

variable "viewer_protocol_policy" {
  description = "Viewer protocol policy."
  type        = string
  default     = "redirect-to-https"

  validation {
    condition = contains(
      [
        "allow-all",
        "https-only",
        "redirect-to-https"
      ],
      var.viewer_protocol_policy
    )

    error_message = "viewer_protocol_policy must be allow-all, https-only, or redirect-to-https."
  }
}

variable "custom_error_responses" {
  description = "Optional CloudFront custom error response configuration."
  type = list(object({
    error_code            = number
    response_code         = optional(number)
    response_page_path    = optional(string)
    error_caching_min_ttl = optional(number, 300)
  }))

  default = []
}

variable "tags" {
  description = "Additional tags for CloudFront."
  type        = map(string)
  default     = {}
}