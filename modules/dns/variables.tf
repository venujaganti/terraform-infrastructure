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

variable "domain_name" {
  description = "Public DNS domain name for the hosted zone."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9.-]+$", var.domain_name))
    error_message = "domain_name must contain only letters, numbers, dots, and hyphens."
  }
}

variable "create_hosted_zone" {
  description = "Whether Terraform should create the Route 53 hosted zone."
  type        = bool
  default     = true
}

variable "hosted_zone_id" {
  description = "Existing Route 53 hosted zone ID. Required when create_hosted_zone is false."
  type        = string
  default     = null

  validation {
    condition = (
      var.hosted_zone_id == null ||
      can(regex("^Z[A-Z0-9]+$", var.hosted_zone_id))
    )
    error_message = "hosted_zone_id must be a valid Route 53 hosted zone ID such as Z123456789."
  }
}

variable "record_name" {
  description = "DNS record name. Use the domain name for the root record or a subdomain such as www."
  type        = string
  default     = null
}

variable "create_alias_record" {
  description = "Whether to create an alias A record."
  type        = bool
  default     = false
}

variable "alias_target_dns_name" {
  description = "DNS name of the alias target, normally the CloudFront distribution domain."
  type        = string
  default     = null
}

variable "alias_target_zone_id" {
  description = "Hosted zone ID of the alias target. CloudFront uses Z2FDTNDATAQYW2."
  type        = string
  default     = null
}

variable "enable_ipv6_record" {
  description = "Whether to create an AAAA alias record in addition to the A record."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags for Route 53 resources."
  type        = map(string)
  default     = {}
}