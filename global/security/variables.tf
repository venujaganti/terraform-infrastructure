variable "key_alias" {
  description = "KMS alias name. Must start with alias/."
  type        = string

  default = "alias/terraform-infrastructure-global"

  validation {
    condition     = can(regex("^alias/[A-Za-z0-9/_+=.@-]{1,250}$", var.key_alias))
    error_message = "key_alias must start with alias/ and contain valid KMS alias characters."
  }
}

variable "key_description" {
  description = "Description of the global KMS key."
  type        = string

  default = "Global security encryption key managed by Terraform."
}

variable "enable_key_rotation" {
  description = "Enable automatic annual KMS key rotation."
  type        = bool

  default = true
}

variable "deletion_window_in_days" {
  description = "Number of days before a scheduled KMS key deletion."
  type        = number

  default = 30

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "deletion_window_in_days must be between 7 and 30 days."
  }
}

variable "tags" {
  description = "Additional tags for the KMS key."
  type        = map(string)

  default = {}
}