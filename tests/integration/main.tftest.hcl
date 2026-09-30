mock_provider "aws" {}

variables {
  project_name = "terraform-infrastructure"
  environment  = "dev"

  aws_region = "ap-south-1"
}

run "integration_environment" {
  command = plan

  assert {
    condition     = var.aws_region == "ap-south-1"
    error_message = "Integration test failed: AWS region must be ap-south-1."
  }

  assert {
    condition = contains(
      ["dev", "staging", "production"],
      var.environment
    )

    error_message = "Integration test failed: invalid environment."
  }

  assert {
    condition     = var.project_name != ""
    error_message = "Integration test failed: project_name must not be empty."
  }
}