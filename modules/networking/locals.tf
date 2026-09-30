locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "networking"
  }

  public_subnets = {
    for index, az in var.availability_zones :
    az => {
      cidr = var.public_subnet_cidrs[index]
    }
  }

  private_subnets = {
    for index, az in var.availability_zones :
    az => {
      cidr = var.private_subnet_cidrs[index]
    }
  }
}