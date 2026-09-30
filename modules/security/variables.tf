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
  description = "ID of the VPC where the security group will be created."
  type        = string

  validation {
    condition     = length(trimspace(var.vpc_id)) > 0
    error_message = "vpc_id must not be empty."
  }
}

variable "ssh_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access SSH."
  type        = list(string)
  default     = []
}

variable "http_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access HTTP."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "https_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access HTTPS."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "jenkins_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access Jenkins."
  type        = list(string)
  default     = []
}

variable "kubernetes_api_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the Kubernetes API."
  type        = list(string)
  default     = []
}

variable "kubernetes_node_allowed_cidr_blocks" {
  description = "CIDR blocks allowed for Kubernetes node communication."
  type        = list(string)
  default     = []
}