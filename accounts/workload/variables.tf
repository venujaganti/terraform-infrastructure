variable "aws_region" {
  description = "AWS region used by the workload account."
  type        = string
  default     = "ap-south-1"
}

variable "workload_account_id" {
  description = "AWS account ID for the workload account."
  type        = string
  default     = null

  validation {
    condition = (
      var.workload_account_id == null ||
      can(regex("^[0-9]{12}$", var.workload_account_id))
    )

    error_message = "workload_account_id must be a 12-digit AWS account ID."
  }
}

variable "project_name" {
  description = "Project name used for identification."
  type        = string
  default     = "terraform-infrastructure"
}