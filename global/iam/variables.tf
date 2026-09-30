variable "role_name" {
  description = "Name of the global IAM role."
  type        = string

  default = "terraform-infrastructure-global-role"

  validation {
    condition     = can(regex("^[A-Za-z0-9+=,.@_-]{1,64}$", var.role_name))
    error_message = "role_name must be 1-64 characters and contain only IAM-supported characters."
  }
}

variable "role_description" {
  description = "Description of the global IAM role."
  type        = string

  default = "Global IAM role managed by Terraform."
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds."
  type        = number

  default = 3600

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "max_session_duration must be between 3600 and 43200 seconds."
  }
}

variable "managed_policy_arns" {
  description = "AWS managed or customer managed policy ARNs to attach to the role."
  type        = set(string)

  default = []
}

variable "create_instance_profile" {
  description = "Whether to create an EC2 instance profile for the IAM role."
  type        = bool

  default = true
}

variable "instance_profile_name" {
  description = "Optional EC2 instance profile name."
  type        = string

  default = null

  validation {
    condition = (
      var.instance_profile_name == null ||
      can(regex("^[A-Za-z0-9+=,.@_-]{1,128}$", var.instance_profile_name))
    )

    error_message = "instance_profile_name must be null or 1-128 characters using IAM-supported characters."
  }
}

variable "tags" {
  description = "Additional tags for IAM resources."
  type        = map(string)

  default = {}
}