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

variable "backup_vault_name" {
  description = "Optional AWS Backup vault name."
  type        = string
  default     = null
}

variable "backup_plan_name" {
  description = "Optional AWS Backup plan name."
  type        = string
  default     = null
}

variable "backup_rule_name" {
  description = "Optional AWS Backup rule name."
  type        = string
  default     = null
}

variable "schedule" {
  description = "AWS Backup schedule in AWS cron format."
  type        = string
  default     = "cron(0 5 * * ? *)"

  validation {
    condition     = startswith(var.schedule, "cron(")
    error_message = "schedule must be an AWS cron expression beginning with cron(."
  }
}

variable "start_window_minutes" {
  description = "Number of minutes before a backup job must start."
  type        = number
  default     = 60

  validation {
    condition = (
      var.start_window_minutes >= 60 &&
      var.start_window_minutes <= 10080
    )

    error_message = "start_window_minutes must be between 60 and 10080."
  }
}

variable "completion_window_minutes" {
  description = "Number of minutes in which the backup job must complete."
  type        = number
  default     = 180

  validation {
    condition = (
      var.completion_window_minutes >= 60 &&
      var.completion_window_minutes <= 10080
    )

    error_message = "completion_window_minutes must be between 60 and 10080."
  }
}

variable "cold_storage_after_days" {
  description = "Number of days before a recovery point moves to cold storage."
  type        = number
  default     = 0

  validation {
    condition     = var.cold_storage_after_days >= 0
    error_message = "cold_storage_after_days must be zero or greater."
  }
}

variable "delete_after_days" {
  description = "Number of days before a recovery point is deleted."
  type        = number
  default     = 30

  validation {
    condition     = var.delete_after_days >= 1
    error_message = "delete_after_days must be at least 1."
  }
}

variable "selection_tag_key" {
  description = "Tag key used to select resources for backup."
  type        = string
  default     = "Backup"
}

variable "selection_tag_value" {
  description = "Tag value used to select resources for backup."
  type        = string
  default     = "true"
}

variable "create_backup_selection" {
  description = "Whether to create the tag-based backup resource selection."
  type        = bool
  default     = true
}

variable "enable_vault_lock" {
  description = "Whether to enable AWS Backup Vault Lock."
  type        = bool
  default     = false
}

variable "vault_lock_min_retention_days" {
  description = "Minimum retention period for Vault Lock."
  type        = number
  default     = 7

  validation {
    condition     = var.vault_lock_min_retention_days >= 1
    error_message = "vault_lock_min_retention_days must be at least 1."
  }
}

variable "vault_lock_max_retention_days" {
  description = "Maximum retention period for Vault Lock."
  type        = number
  default     = 365

  validation {
    condition     = var.vault_lock_max_retention_days >= 1
    error_message = "vault_lock_max_retention_days must be at least 1."
  }
}

variable "tags" {
  description = "Additional tags for backup resources."
  type        = map(string)
  default     = {}
}