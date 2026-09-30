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

variable "application_log_group_name" {
  description = "Optional application log group name."
  type        = string
  default     = null
}

variable "application_log_retention_days" {
  description = "Retention period for application logs."
  type        = number
  default     = 30

  validation {
    condition = contains(
      [
        1,
        3,
        5,
        7,
        14,
        30,
        60,
        90,
        120,
        150,
        180,
        365,
        400,
        545,
        731,
        1827,
        3653
      ],
      var.application_log_retention_days
    )

    error_message = "application_log_retention_days must be a supported CloudWatch Logs retention value."
  }
}

variable "system_log_group_name" {
  description = "Optional system log group name."
  type        = string
  default     = null
}

variable "system_log_retention_days" {
  description = "Retention period for system logs."
  type        = number
  default     = 30

  validation {
    condition = contains(
      [
        1,
        3,
        5,
        7,
        14,
        30,
        60,
        90,
        120,
        150,
        180,
        365,
        400,
        545,
        731,
        1827,
        3653
      ],
      var.system_log_retention_days
    )

    error_message = "system_log_retention_days must be a supported CloudWatch Logs retention value."
  }
}

variable "audit_log_group_name" {
  description = "Optional audit log group name."
  type        = string
  default     = null
}

variable "audit_log_retention_days" {
  description = "Retention period for audit logs."
  type        = number
  default     = 90

  validation {
    condition = contains(
      [
        1,
        3,
        5,
        7,
        14,
        30,
        60,
        90,
        120,
        150,
        180,
        365,
        400,
        545,
        731,
        1827,
        3653
      ],
      var.audit_log_retention_days
    )

    error_message = "audit_log_retention_days must be a supported CloudWatch Logs retention value."
  }
}

variable "create_application_log_group" {
  description = "Whether to create the application log group."
  type        = bool
  default     = true
}

variable "create_system_log_group" {
  description = "Whether to create the system log group."
  type        = bool
  default     = true
}

variable "create_audit_log_group" {
  description = "Whether to create the audit log group."
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "Optional KMS key ARN for CloudWatch Logs encryption."
  type        = string
  default     = null
}

variable "skip_destroy" {
  description = "Whether to retain log groups when Terraform destroys them."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for logging resources."
  type        = map(string)
  default     = {}
}