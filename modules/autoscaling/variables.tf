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

variable "ami_id" {
  description = "AMI ID used by the Auto Scaling Launch Template."
  type        = string

  validation {
    condition     = length(trimspace(var.ami_id)) > 0
    error_message = "ami_id must not be empty."
  }
}

variable "instance_type" {
  description = "EC2 instance type used by the Auto Scaling Group."
  type        = string
  default     = "m7i-flex.large"
}

variable "subnet_ids" {
  description = "Subnet IDs where Auto Scaling instances will be launched."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required for high availability."
  }
}

variable "security_group_ids" {
  description = "Security group IDs attached to Auto Scaling instances."
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "At least one security group ID is required."
  }
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile attached to Auto Scaling instances."
  type        = string
  default     = null
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name."
  type        = string
  default     = null
}

variable "user_data" {
  description = "Optional user-data script for EC2 instances."
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Root EBS volume size in GiB."
  type        = number
  default     = 40

  validation {
    condition     = var.root_volume_size >= 8
    error_message = "root_volume_size must be at least 8 GiB."
  }
}

variable "root_volume_type" {
  description = "Root EBS volume type."
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["gp3", "gp2", "io1", "io2"], var.root_volume_type)
    error_message = "root_volume_type must be gp3, gp2, io1, or io2."
  }
}

variable "min_size" {
  description = "Minimum number of Auto Scaling instances."
  type        = number
  default     = 2

  validation {
    condition     = var.min_size >= 1
    error_message = "min_size must be at least 1."
  }
}

variable "desired_capacity" {
  description = "Desired number of Auto Scaling instances."
  type        = number
  default     = 2

  validation {
    condition     = var.desired_capacity >= 1
    error_message = "desired_capacity must be at least 1."
  }
}

variable "max_size" {
  description = "Maximum number of Auto Scaling instances."
  type        = number
  default     = 4

  validation {
    condition     = var.max_size >= 1
    error_message = "max_size must be at least 1."
  }
}

variable "target_group_arns" {
  description = "Target group ARNs where Auto Scaling instances will be registered."
  type        = list(string)

  validation {
    condition     = length(var.target_group_arns) > 0
    error_message = "At least one target group ARN is required."
  }
}

variable "health_check_type" {
  description = "Health check type used by the Auto Scaling Group."
  type        = string
  default     = "ELB"

  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "health_check_type must be EC2 or ELB."
  }
}

variable "health_check_grace_period" {
  description = "Health check grace period in seconds."
  type        = number
  default     = 300

  validation {
    condition     = var.health_check_grace_period >= 0
    error_message = "health_check_grace_period must not be negative."
  }
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed EC2 monitoring."
  type        = bool
  default     = false
}