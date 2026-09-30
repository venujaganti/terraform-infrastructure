variable "project_name" {
  description = "Project name."
  type        = string

  validation {
    condition     = trimspace(var.project_name) != ""
    error_message = "project_name must not be empty."
  }
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

variable "allowed_ingress_ports" {
  description = "Approved inbound TCP ports."
  type        = set(number)

  default = [
    22,
    80,
    443,
    8080,
    6443,
    10250
  ]

  validation {
    condition = alltrue([
      for port in var.allowed_ingress_ports :
      port >= 1 && port <= 65535
    ])

    error_message = "Every ingress port must be between 1 and 65535."
  }
}

variable "allow_public_http_https" {
  description = "Whether HTTP and HTTPS are allowed from the internet."
  type        = bool
  default     = true
}

variable "allow_public_ssh" {
  description = "Whether SSH is allowed from the internet."
  type        = bool
  default     = false
}