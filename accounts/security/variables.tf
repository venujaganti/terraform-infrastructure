variable "aws_region" {
  description = "AWS region used by the security account."
  type        = string
  default     = "ap-south-1"
}

variable "security_account_id" {
  description = "AWS account ID for the security account."
  type        = string
  default     = null

  validation {
    condition = (
      var.security_account_id == null ||
      can(regex("^[0-9]{12}$", var.security_account_id))
    )

    error_message = "security_account_id must be a 12-digit AWS account ID."
  }
}

variable "project_name" {
  description = "Project name used for identification."
  type        = string
  default     = "terraform-infrastructure"
}