resource "terraform_data" "encryption_compliance" {
  input = {
    encrypted_resources = join(
      ",",
      sort(tolist(local.required_resources))
    )
  }

  lifecycle {
    precondition {
      condition = (
        length(local.required_resources) > 0
      )

      error_message = "At least one encrypted resource type must be configured."
    }
  }
}