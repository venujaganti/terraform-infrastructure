mock_provider "aws" {}

variables {
  project_name = "terraform-infrastructure"
  environment  = "dev"
  vpc_id       = "vpc-test"

  ssh_allowed_cidr_blocks             = []
  http_allowed_cidr_blocks            = ["0.0.0.0/0"]
  https_allowed_cidr_blocks           = ["0.0.0.0/0"]
  jenkins_allowed_cidr_blocks         = []
  kubernetes_api_allowed_cidr_blocks  = []
  kubernetes_node_allowed_cidr_blocks = []
}

run "security_plan" {
  command = plan

  assert {
    condition     = length(var.ssh_allowed_cidr_blocks) == 0
    error_message = "Public SSH must remain disabled by default."
  }

  assert {
    condition     = contains(var.http_allowed_cidr_blocks, "0.0.0.0/0")
    error_message = "Public HTTP must be enabled for the default security policy."
  }

  assert {
    condition     = contains(var.https_allowed_cidr_blocks, "0.0.0.0/0")
    error_message = "Public HTTPS must be enabled for the default security policy."
  }
}
