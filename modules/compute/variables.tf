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
  description = "AMI ID used for the EC2 instance."
  type        = string

  validation {
    condition     = length(trimspace(var.ami_id)) > 0
    error_message = "ami_id must not be empty."
  }
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "m7i-flex.large"
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched."
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs attached to the EC2 instance."
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name."
  type        = string
  default     = null
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile attached to the EC2 instance."
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IPv4 address with the instance."
  type        = bool
  default     = true
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

variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring for the EC2 instance."
  type        = bool
  default     = false
}

variable "user_data" {
  description = "Optional EC2 user-data script."
  type        = string
  default     = null
}