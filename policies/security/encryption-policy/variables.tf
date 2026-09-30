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

variable "require_ebs_encryption" {
  description = "Require EBS volumes to be encrypted."
  type        = bool
  default     = true
}

variable "require_rds_encryption" {
  description = "Require RDS storage encryption."
  type        = bool
  default     = true
}

variable "require_s3_encryption" {
  description = "Require S3 server-side encryption."
  type        = bool
  default     = true
}