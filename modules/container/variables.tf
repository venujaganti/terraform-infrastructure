variable "project_name" {
  description = "Name of the project."
  type        = string

  validation {
    condition     = length(trimspace(var.project_name)) > 0
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

variable "repository_name" {
  description = "Optional ECR repository name. If null, a project/environment name is generated."
  type        = string
  default     = null

  validation {
    condition = (
      var.repository_name == null ||
      can(regex("^[a-z0-9]+([._/-][a-z0-9]+)*$", var.repository_name))
    )
    error_message = "repository_name must contain only lowercase letters, numbers, periods, underscores, and hyphens."
  }
}

variable "image_tag_mutability" {
  description = "ECR image tag mutability."
  type        = string
  default     = "MUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable vulnerability scanning when images are pushed."
  type        = bool
  default     = true
}

variable "force_delete" {
  description = "Allow Terraform to delete the repository even when images exist."
  type        = bool
  default     = false
}