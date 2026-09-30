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

variable "function_name" {
  description = "Optional Lambda function name."
  type        = string
  default     = null
}

variable "runtime" {
  description = "Lambda runtime."
  type        = string
  default     = "python3.12"

  validation {
    condition = contains(
      [
        "python3.12",
        "python3.13",
        "nodejs20.x",
        "nodejs22.x"
      ],
      var.runtime
    )

    error_message = "runtime must be one of the supported Lambda runtimes."
  }
}

variable "handler" {
  description = "Lambda function handler."
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_package_path" {
  description = "Path to the Lambda deployment ZIP package."
  type        = string

  validation {
    condition     = length(trimspace(var.lambda_package_path)) > 0
    error_message = "lambda_package_path must not be empty."
  }
}

variable "memory_size" {
  description = "Lambda memory size in MB."
  type        = number
  default     = 256

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "memory_size must be between 128 MB and 10240 MB."
  }
}

variable "timeout" {
  description = "Lambda timeout in seconds."
  type        = number
  default     = 30

  validation {
    condition     = var.timeout >= 1 && var.timeout <= 900
    error_message = "timeout must be between 1 and 900 seconds."
  }
}

variable "architectures" {
  description = "Instruction set architecture used by Lambda."
  type        = list(string)
  default     = ["x86_64"]

  validation {
    condition = alltrue([
      for architecture in var.architectures :
      contains(["x86_64", "arm64"], architecture)
    ])

    error_message = "architectures must contain only x86_64 or arm64."
  }
}

variable "environment_variables" {
  description = "Environment variables passed to the Lambda function."
  type        = map(string)
  default     = {}
}

variable "reserved_concurrency" {
  description = "Reserved concurrent executions. Set to null to disable the reservation."
  type        = number
  default     = null

  validation {
    condition = (
      var.reserved_concurrency == null ||
      var.reserved_concurrency >= 0
    )

    error_message = "reserved_concurrency must be null or greater than or equal to zero."
  }
}

variable "log_retention_days" {
  description = "CloudWatch Logs retention period."
  type        = number
  default     = 30

  validation {
    condition = contains(
      [
        1,
        3,
        5,
        7,
        14,
        30,
        60,
        90,
        120,
        150,
        180,
        365,
        400,
        545,
        731,
        1827,
        3653
      ],
      var.log_retention_days
    )

    error_message = "log_retention_days must be a valid CloudWatch Logs retention value."
  }
}