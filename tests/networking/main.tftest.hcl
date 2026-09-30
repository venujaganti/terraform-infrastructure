mock_provider "aws" {}

variables {
  project_name = "terraform-infrastructure"
  environment  = "dev"

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

run "networking_plan" {
  command = plan

  assert {
    condition     = var.vpc_cidr == "10.0.0.0/16"
    error_message = "Networking test failed: VPC CIDR is incorrect."
  }

  assert {
    condition     = length(var.availability_zones) >= 2
    error_message = "Networking test failed: at least two AZs are required."
  }

  assert {
    condition = (
      length(var.public_subnet_cidrs) ==
      length(var.availability_zones)
    )

    error_message = "Public subnet CIDR count must match AZ count."
  }

  assert {
    condition = (
      length(var.private_subnet_cidrs) ==
      length(var.availability_zones)
    )

    error_message = "Private subnet CIDR count must match AZ count."
  }
}