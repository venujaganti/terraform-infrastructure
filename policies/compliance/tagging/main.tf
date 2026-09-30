resource "terraform_data" "tagging_policy" {
  input = {
    required_tags = join(",", sort(tolist(local.required_tag_set)))
  }

  lifecycle {
    precondition {
      condition = alltrue([
        for tag in local.required_tag_set :
        can(regex("^[A-Za-z0-9_-]+$", tag))
      ])

      error_message = "Required tag names may contain letters, numbers, underscores, and hyphens."
    }
  }
}