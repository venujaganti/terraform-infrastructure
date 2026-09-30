variable "domain_name" {
  description = "Fully qualified domain name for the Route 53 hosted zone."
  type        = string

  validation {
    condition     = length(trimspace(var.domain_name)) > 0
    error_message = "domain_name must not be empty."
  }
}

variable "comment" {
  description = "Comment associated with the Route 53 hosted zone."
  type        = string

  default = "Global DNS zone managed by Terraform."
}

variable "force_destroy" {
  description = "Whether Route 53 records can be deleted automatically when destroying the hosted zone."
  type        = bool

  default = false
}

variable "create_verification_record" {
  description = "Whether to create an optional TXT verification record."
  type        = bool

  default = false
}

variable "verification_record_name" {
  description = "Name of the optional TXT verification record."
  type        = string

  default = "_terraform-verification"
}

variable "verification_record_value" {
  description = "Value of the optional TXT verification record."
  type        = string

  default = "managed-by-terraform"
}

variable "tags" {
  description = "Additional tags for the Route 53 hosted zone."
  type        = map(string)

  default = {}
}