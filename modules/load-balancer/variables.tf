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

variable "vpc_id" {
  description = "VPC ID where the load balancer and target group will be created."
  type        = string

  validation {
    condition     = length(trimspace(var.vpc_id)) > 0
    error_message = "vpc_id must not be empty."
  }
}

variable "subnet_ids" {
  description = "Subnet IDs used by the Application Load Balancer."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required for an Application Load Balancer."
  }
}

variable "security_group_ids" {
  description = "Security group IDs attached to the Application Load Balancer."
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "At least one security group ID is required."
  }
}

variable "target_port" {
  description = "Port used by the application targets."
  type        = number
  default     = 80

  validation {
    condition     = var.target_port >= 1 && var.target_port <= 65535
    error_message = "target_port must be between 1 and 65535."
  }
}

variable "listener_port" {
  description = "Port exposed by the Application Load Balancer."
  type        = number
  default     = 80

  validation {
    condition     = var.listener_port >= 1 && var.listener_port <= 65535
    error_message = "listener_port must be between 1 and 65535."
  }
}

variable "health_check_path" {
  description = "HTTP path used by the target group health check."
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "Protocol used by the target group health check."
  type        = string
  default     = "HTTP"

  validation {
    condition     = contains(["HTTP", "HTTPS"], var.health_check_protocol)
    error_message = "health_check_protocol must be HTTP or HTTPS."
  }
}

variable "target_protocol" {
  description = "Protocol used to communicate with application targets."
  type        = string
  default     = "HTTP"

  validation {
    condition     = contains(["HTTP", "HTTPS"], var.target_protocol)
    error_message = "target_protocol must be HTTP or HTTPS."
  }
}

variable "internal" {
  description = "Whether the Application Load Balancer is internal."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection on the Application Load Balancer."
  type        = bool
  default     = false
}