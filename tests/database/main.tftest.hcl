mock_provider "aws" {}

variables {
  project_name = "terraform-infrastructure"
  environment  = "dev"

  subnet_ids = [
    "subnet-a",
    "subnet-b"
  ]

  security_group_ids = [
    "sg-test"
  ]
}

run "database_plan" {
  command = plan

  assert {
    condition     = var.project_name != ""
    error_message = "Database test failed: project_name must not be empty."
  }

  assert {
    condition = contains(
      ["dev", "staging", "production"],
      var.environment
    )

    error_message = "Database test failed: invalid environment."
  }

  assert {
    condition     = length(var.subnet_ids) >= 2
    error_message = "Database test failed: at least two subnets are required."
  }
}
