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
variable "aws_region" { type = string }

resource "terraform_data" "integration" {
  input = {
    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region
  }
}
