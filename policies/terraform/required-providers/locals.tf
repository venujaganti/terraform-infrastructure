locals {
  terraform_constraint = ">= ${var.terraform_minimum_version}, < ${var.terraform_maximum_version}"

  provider_constraints = {
    aws = var.aws_provider_constraint
  }
}