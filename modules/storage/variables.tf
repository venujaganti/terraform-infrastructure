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

variable "bucket_name" {
  description = "Optional globally unique S3 bucket name. If null, a Terraform-generated name is used."
  type        = string
  default     = null

  validation {
    condition = (
      var.bucket_name == null ||
      can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    )
    error_message = "bucket_name must be a valid S3 bucket name."
  }
}

variable "force_destroy" {
  description = "Allow Terraform to delete all objects when destroying the bucket."
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable S3 object versioning."
  type        = bool
  default     = true
}

variable "object_lock_enabled" {
  description = "Enable S3 Object Lock."
  type        = bool
  default     = false
}