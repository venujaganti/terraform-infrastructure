resource "terraform_data" "logging_policy" {
  input = {
    services       = join(",", local.logging_requirements.services)
    retention_days = local.logging_requirements.retention_days
  }

  lifecycle {
    precondition {
      condition = (
        length(local.logging_requirements.services) > 0
      )

      error_message = "At least one logging service must be configured."
    }
  }
}