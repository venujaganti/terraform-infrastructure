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
variable "vpc_id" { type = string }
variable "ssh_allowed_cidr_blocks" { type = list(string) }
variable "http_allowed_cidr_blocks" { type = list(string) }
variable "https_allowed_cidr_blocks" { type = list(string) }
variable "jenkins_allowed_cidr_blocks" { type = list(string) }
variable "kubernetes_api_allowed_cidr_blocks" { type = list(string) }
variable "kubernetes_node_allowed_cidr_blocks" { type = list(string) }

module "security" {
  source = "../../modules/security"

  project_name                         = var.project_name
  environment                          = var.environment
  vpc_id                               = var.vpc_id
  ssh_allowed_cidr_blocks              = var.ssh_allowed_cidr_blocks
  http_allowed_cidr_blocks             = var.http_allowed_cidr_blocks
  https_allowed_cidr_blocks            = var.https_allowed_cidr_blocks
  jenkins_allowed_cidr_blocks          = var.jenkins_allowed_cidr_blocks
  kubernetes_api_allowed_cidr_blocks   = var.kubernetes_api_allowed_cidr_blocks
  kubernetes_node_allowed_cidr_blocks  = var.kubernetes_node_allowed_cidr_blocks
}
