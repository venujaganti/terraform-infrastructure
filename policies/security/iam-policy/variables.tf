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

variable "allow_wildcard_actions" {
  description = "Whether wildcard IAM actions are allowed."
  type        = bool
  default     = false
}

variable "allowed_services" {
  description = "AWS services approved for IAM permissions."
  type        = set(string)

  default = [
    "ec2",
    "s3",
    "logs",
    "cloudwatch",
    "ssm"
  ]

  validation {
    condition = alltrue([
      for service in var.allowed_services :
      can(regex("^[a-z0-9-]+$", service))
    ])

    error_message = "AWS service names may contain lowercase letters, numbers, and hyphens."
  }
}