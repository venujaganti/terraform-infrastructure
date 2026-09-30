terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "project_name" { type = string }
variable "environment" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }

module "database" {
  source = "../../modules/database"

  project_name       = var.project_name
  environment        = var.environment
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
}
