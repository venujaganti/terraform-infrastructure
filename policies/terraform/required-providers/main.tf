terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "terraform_data" "required_providers_policy" {
  input = {
    terraform_constraint = local.terraform_constraint
    aws_provider         = local.provider_constraints.aws
  }

  lifecycle {
    precondition {
      condition = (
        var.terraform_minimum_version != "" &&
        var.terraform_maximum_version != "" &&
        var.aws_provider_constraint != ""
      )

      error_message = "Terraform and provider version constraints must not be empty."
    }
  }
}