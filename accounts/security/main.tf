data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  expected_account_id = var.security_account_id

  account_id = data.aws_caller_identity.current.account_id

  common_tags = {
    Project     = var.project_name
    AccountRole = "security"
    ManagedBy   = "Terraform"
  }
}

resource "terraform_data" "account_validation" {
  input = {
    account_id = local.account_id
    region     = data.aws_region.current.name
  }

  lifecycle {
    precondition {
      condition = (
        local.expected_account_id == null ||
        local.account_id == local.expected_account_id
      )

      error_message = "The configured AWS credentials do not belong to the expected security account."
    }
  }
}

output "account_id" {
  description = "AWS account ID detected by Terraform."
  value       = local.account_id
}

output "region" {
  description = "AWS region."
  value       = data.aws_region.current.name
}

output "account_role" {
  description = "Purpose of this AWS account."
  value       = "security"
}