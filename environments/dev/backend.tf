# Phase 2 foundation uses the local Terraform backend.
# Configure an S3 backend in a later phase after the AWS state-management
# resources have been created.

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}