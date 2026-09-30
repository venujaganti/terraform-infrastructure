resource "terraform_data" "required_tags_policy" {
  input = local.normalized_tags

  lifecycle {
    precondition {
      condition = alltrue([
        for key in keys(local.normalized_tags) :
        can(regex("^[A-Za-z0-9_-]+$", key))
      ])

      error_message = "Tag keys may contain letters, numbers, underscores, and hyphens."
    }
  }
}