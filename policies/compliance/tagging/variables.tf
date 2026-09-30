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

variable "required_tags" {
  description = "Tags required on managed resources."
  type        = set(string)

  default = [
    "Project",
    "Environment",
    "ManagedBy"
  ]

  validation {
    condition = alltrue([
      for tag in var.required_tags :
      trimspace(tag) != ""
    ])

    error_message = "Required tag names must not be empty."
  }
}