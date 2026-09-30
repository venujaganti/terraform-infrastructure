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

variable "subnet_ids" {
  description = "Private subnet IDs used by the RDS subnet group."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required for the RDS subnet group."
  }
}

variable "security_group_ids" {
  description = "Security group IDs attached to the RDS instance."
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) >= 1
    error_message = "At least one security group ID is required."
  }
}

variable "engine" {
  description = "RDS database engine."
  type        = string
  default     = "postgres"

  validation {
    condition     = var.engine == "postgres"
    error_message = "This module currently supports the PostgreSQL engine only."
  }
}

variable "engine_version" {
  description = "PostgreSQL engine version."
  type        = string
  default     = "17"
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Initial database storage in GiB."
  type        = number
  default     = 20

  validation {
    condition     = var.allocated_storage >= 20
    error_message = "allocated_storage must be at least 20 GiB."
  }
}

variable "max_allocated_storage" {
  description = "Maximum storage size for autoscaling in GiB."
  type        = number
  default     = 100

  validation {
    condition     = var.max_allocated_storage >= 20
    error_message = "max_allocated_storage must be at least 20 GiB."
  }
}

variable "storage_type" {
  description = "RDS storage type."
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2"], var.storage_type)
    error_message = "storage_type must be gp2, gp3, io1, or io2."
  }
}

variable "database_name" {
  description = "Initial database name."
  type        = string
  default     = "appdb"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_]{0,62}$", var.database_name))
    error_message = "database_name must start with a letter and contain only letters, numbers, and underscores."
  }
}

variable "master_username" {
  description = "Master username for the PostgreSQL database."
  type        = string
  default     = "appadmin"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_]{0,15}$", var.master_username))
    error_message = "master_username must start with a letter and contain only letters, numbers, and underscores."
  }
}

variable "port" {
  description = "PostgreSQL database port."
  type        = number
  default     = 5432

  validation {
    condition     = var.port >= 1 && var.port <= 65535
    error_message = "port must be between 1 and 65535."
  }
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups."
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "backup_retention_period must be between 0 and 35 days."
  }
}

variable "backup_window" {
  description = "Preferred daily backup window."
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred weekly maintenance window."
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable RDS deletion protection."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot when the database is destroyed."
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply database modifications immediately."
  type        = bool
  default     = false
}