variable "project_name" {
  description = "Project name."
  type        = string
  default     = "terraform-infrastructure"
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

variable "required_logging_services" {
  description = "AWS services that should have centralized logging."
  type        = set(string)

  default = [
    "cloudtrail",
    "cloudwatch",
    "vpc-flow-logs"
  ]

  validation {
    condition = alltrue([
      for service in var.required_logging_services :
      trimspace(service) != ""
    ])

    error_message = "Logging service names must not be empty."
  }
}

variable "log_retention_days" {
  description = "Required minimum log retention period."
  type        = number
  default     = 90

  validation {
    condition = (
      var.log_retention_days >= 1 &&
      var.log_retention_days <= 3653
    )

    error_message = "log_retention_days must be between 1 and 3653."
  }
}