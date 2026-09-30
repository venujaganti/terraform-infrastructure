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
variable "instance_type" { type = string }
variable "root_volume_size" { type = number }
variable "root_volume_type" { type = string }
variable "subnet_id" { type = string }
variable "security_group_ids" { type = list(string) }
variable "ami_id" { type = string }
variable "key_name" { type = string }
variable "iam_instance_profile_name" { type = string }

module "compute" {
  source = "../../modules/compute"

  project_name                 = var.project_name
  environment                  = var.environment
  instance_type                = var.instance_type
  root_volume_size             = var.root_volume_size
  root_volume_type             = var.root_volume_type
  subnet_id                    = var.subnet_id
  security_group_ids           = var.security_group_ids
  ami_id                       = var.ami_id
  key_name                     = var.key_name
  iam_instance_profile_name    = var.iam_instance_profile_name
}
