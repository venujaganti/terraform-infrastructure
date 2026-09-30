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

variable "encrypted_resources" {
  description = "Resources that must use encryption."
  type        = set(string)

  default = [
    "ebs",
    "rds",
    "s3",
    "secrets-manager"
  ]

  validation {
    condition = alltrue([
      for resource_type in var.encrypted_resources :
      trimspace(resource_type) != ""
    ])

    error_message = "Encrypted resource names must not be empty."
  }
}