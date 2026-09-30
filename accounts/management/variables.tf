variable "aws_region" {
  description = "AWS region used by the management account."
  type        = string
  default     = "ap-south-1"
}

variable "management_account_id" {
  description = "AWS account ID for the management account."
  type        = string
  default     = null

  validation {
    condition = (
      var.management_account_id == null ||
      can(regex("^[0-9]{12}$", var.management_account_id))
    )

    error_message = "management_account_id must be a 12-digit AWS account ID."
  }
}

variable "project_name" {
  description = "Project name used for identification."
  type        = string
  default     = "terraform-infrastructure"
}