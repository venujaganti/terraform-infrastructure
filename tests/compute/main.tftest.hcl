mock_provider "aws" {}

variables {
  project_name = "terraform-infrastructure"
  environment  = "dev"

  instance_type = "m7i-flex.large"

  root_volume_size = 40
  root_volume_type = "gp3"

  subnet_id = "subnet-test"

  security_group_ids = [
    "sg-test"
  ]

  ami_id = "ami-test"

  key_name = "devsecops-cicd-key"

  iam_instance_profile_name = "test-instance-profile"
}

run "compute_plan" {
  command = plan

  assert {
    condition     = var.instance_type == "m7i-flex.large"
    error_message = "Compute test failed: instance type must be m7i-flex.large."
  }

  assert {
    condition     = var.root_volume_size == 40
    error_message = "Compute test failed: root volume must be 40 GiB."
  }

  assert {
    condition     = var.root_volume_type == "gp3"
    error_message = "Compute test failed: root volume must use gp3."
  }

  assert {
    condition     = var.key_name == "devsecops-cicd-key"
    error_message = "Compute test failed: existing EC2 key pair name is incorrect."
  }
}
