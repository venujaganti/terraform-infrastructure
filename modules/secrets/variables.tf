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
    condition = contains(
      ["dev", "staging", "production"],
      var.environment
    )

    error_message = "environment must be dev, staging, or production."
  }
}

variable "secret_name" {
  description = "Optional Secrets Manager secret name."
  type        = string
  default     = null

  validation {
    condition = (
      var.secret_name == null ||
      can(regex("^[A-Za-z0-9/_+=.@-]+$", var.secret_name))
    )

    error_message = "secret_name contains unsupported characters."
  }
}

variable "description" {
  description = "Description of the secret."
  type        = string
  default     = "Application secret managed by Terraform."
}

variable "secret_value" {
  description = "Optional initial secret value. Keep this sensitive."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_values" {
  description = "Optional key-value map stored as a JSON secret."
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "kms_key_id" {
  description = "Optional KMS key ARN or ID used to encrypt the secret."
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Number of days before a deleted secret is permanently removed."
  type        = number
  default     = 7

  validation {
    condition = (
      var.recovery_window_in_days >= 0 &&
      var.recovery_window_in_days <= 30
    )

    error_message = "recovery_window_in_days must be between 0 and 30."
  }
}

variable "force_overwrite_replica_secret" {
  description = "Whether to overwrite a replica secret with the same name."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for the secret."
  type        = map(string)
  default     = {}
}