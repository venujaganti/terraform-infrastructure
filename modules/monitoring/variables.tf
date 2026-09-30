variable "project_name" {
  description = "Project name used for resource naming and tagging."
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

variable "create_cpu_alarm" {
  description = "Whether to create the CPU utilization CloudWatch alarm."
  type        = bool
  default     = true
}

variable "alarm_instance_id" {
  description = "EC2 instance ID monitored by the CPU alarm. Leave null to skip the alarm."
  type        = string
  default     = null

  validation {
    condition = (
      var.alarm_instance_id == null ||
      can(regex("^i-[a-f0-9]+$", var.alarm_instance_id))
    )

    error_message = "alarm_instance_id must be a valid EC2 instance ID such as i-0123456789abcdef0."
  }
}

variable "cpu_threshold" {
  description = "CPU utilization percentage that triggers the alarm."
  type        = number
  default     = 80

  validation {
    condition = (
      var.cpu_threshold > 0 &&
      var.cpu_threshold <= 100
    )

    error_message = "cpu_threshold must be greater than 0 and less than or equal to 100."
  }
}

variable "evaluation_periods" {
  description = "Number of periods over which the metric is evaluated."
  type        = number
  default     = 2

  validation {
    condition = (
      var.evaluation_periods >= 1 &&
      var.evaluation_periods <= 100
    )

    error_message = "evaluation_periods must be between 1 and 100."
  }
}

variable "period" {
  description = "Metric evaluation period in seconds."
  type        = number
  default     = 300

  validation {
    condition = contains(
      [10, 20, 30, 60, 120, 180, 240, 300, 360, 420],
      var.period
    )

    error_message = "period must be a supported CloudWatch period."
  }
}

variable "statistic" {
  description = "CloudWatch statistic used by the alarm."
  type        = string
  default     = "Average"

  validation {
    condition = contains(
      ["SampleCount", "Average", "Sum", "Minimum", "Maximum"],
      var.statistic
    )

    error_message = "statistic must be SampleCount, Average, Sum, Minimum, or Maximum."
  }
}

variable "comparison_operator" {
  description = "CloudWatch alarm comparison operator."
  type        = string
  default     = "GreaterThanOrEqualToThreshold"

  validation {
    condition = contains(
      [
        "GreaterThanOrEqualToThreshold",
        "GreaterThanThreshold",
        "LessThanThreshold",
        "LessThanOrEqualToThreshold"
      ],
      var.comparison_operator
    )

    error_message = "comparison_operator must be a supported CloudWatch comparison operator."
  }
}

variable "alarm_description" {
  description = "Description of the CPU utilization alarm."
  type        = string
  default     = "Alarm when EC2 CPU utilization exceeds the configured threshold."
}

variable "sns_topic_arn" {
  description = "Optional SNS topic ARN for alarm notifications."
  type        = string
  default     = null

  validation {
    condition = (
      var.sns_topic_arn == null ||
      can(regex("^arn:[^:]+:sns:[^:]+:[0-9]{12}:.+$", var.sns_topic_arn))
    )

    error_message = "sns_topic_arn must be a valid SNS topic ARN."
  }
}

variable "treat_missing_data" {
  description = "How CloudWatch handles missing metric data."
  type        = string
  default     = "notBreaching"

  validation {
    condition = contains(
      [
        "missing",
        "ignore",
        "breaching",
        "notBreaching"
      ],
      var.treat_missing_data
    )

    error_message = "treat_missing_data must be missing, ignore, breaching, or notBreaching."
  }

  }

variable "tags" {
  description = "Additional tags for monitoring resources."
  type        = map(string)
  default     = {}
}