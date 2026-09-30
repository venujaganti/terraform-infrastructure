resource "terraform_data" "iam_policy" {
  input = local.iam_policy_summary

  lifecycle {
    precondition {
      condition = (
        var.environment != "production" ||
        !var.allow_wildcard_actions
      )

      error_message = "Wildcard IAM actions are not allowed in the production environment."
    }
  }
}