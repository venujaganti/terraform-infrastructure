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

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.33"
}

variable "subnet_ids" {
  description = "Subnet IDs used by the EKS cluster and managed node group."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required for the EKS cluster."
  }
}

variable "node_subnet_ids" {
  description = "Subnet IDs used specifically by EKS worker nodes."
  type        = list(string)
  default     = null

  validation {
    condition = (
      var.node_subnet_ids == null ||
      length(var.node_subnet_ids) >= 2
    )
    error_message = "node_subnet_ids must contain at least two subnet IDs when provided."
  }
}

variable "node_instance_types" {
  description = "EC2 instance types used by the EKS managed node group."
  type        = list(string)
  default     = ["m7i-flex.large"]

  validation {
    condition     = length(var.node_instance_types) > 0
    error_message = "At least one node instance type is required."
  }
}

variable "node_capacity_type" {
  description = "Capacity type for the EKS managed node group."
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_min_size" {
  description = "Minimum number of EKS worker nodes."
  type        = number
  default     = 2

  validation {
    condition     = var.node_min_size >= 1
    error_message = "node_min_size must be at least 1."
  }
}

variable "node_desired_size" {
  description = "Desired number of EKS worker nodes."
  type        = number
  default     = 2

  validation {
    condition     = var.node_desired_size >= 1
    error_message = "node_desired_size must be at least 1."
  }
}

variable "node_max_size" {
  description = "Maximum number of EKS worker nodes."
  type        = number
  default     = 4

  validation {
    condition     = var.node_max_size >= 1
    error_message = "node_max_size must be at least 1."
  }
}

variable "endpoint_public_access" {
  description = "Allow public access to the EKS Kubernetes API endpoint."
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Allow private access to the EKS Kubernetes API endpoint."
  type        = bool
  default     = true
}

variable "cluster_log_types" {
  description = "EKS control plane log types to enable."
  type        = list(string)

  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}

variable "cluster_security_group_ids" {
  description = "Additional security groups for the EKS control plane."
  type        = list(string)
  default     = []
}