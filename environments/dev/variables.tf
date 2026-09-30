variable "aws_region" {
  description = "AWS region where this environment will be deployed."
  type        = string
}

variable "environment" {
  description = "Deployment environment name."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "project_name" {
  description = "Project name used for resource naming and tags."
  type        = string
}