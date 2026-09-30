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

variable "lambda_function_name" {
  description = "Name of the Lambda function integrated with API Gateway."
  type        = string

  validation {
    condition     = length(trimspace(var.lambda_function_name)) > 0
    error_message = "lambda_function_name must not be empty."
  }
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function integrated with API Gateway."
  type        = string

  validation {
    condition     = length(trimspace(var.lambda_function_arn)) > 0
    error_message = "lambda_function_arn must not be empty."
  }
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function."
  type        = string

  validation {
    condition     = length(trimspace(var.lambda_invoke_arn)) > 0
    error_message = "lambda_invoke_arn must not be empty."
  }
}

variable "api_name" {
  description = "Optional API Gateway HTTP API name."
  type        = string
  default     = null
}

variable "route_key" {
  description = "API Gateway HTTP API route."
  type        = string
  default     = "ANY /{proxy+}"

  validation {
    condition     = length(trimspace(var.route_key)) > 0
    error_message = "route_key must not be empty."
  }
}

variable "cors_allow_origins" {
  description = "Allowed CORS origins."
  type        = list(string)
  default     = ["*"]
}

variable "enable_access_logs" {
  description = "Whether API Gateway access logging is enabled."
  type        = bool
  default     = true

  validation {
    condition     = var.enable_access_logs == true || var.enable_access_logs == false
    error_message = "enable_access_logs must be true or false."
  }
}