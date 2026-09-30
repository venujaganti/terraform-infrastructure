resource "terraform_data" "encryption_policy" {
  input = local.encryption_requirements

  lifecycle {
    precondition {
      condition = alltrue([
        for requirement in values(local.encryption_requirements) :
        requirement == true
      ])

      error_message = "All configured encryption requirements must be enabled."
    }
  }
}