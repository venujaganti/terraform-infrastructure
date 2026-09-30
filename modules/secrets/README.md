# Secrets Module

This module manages application secrets using AWS Secrets Manager.

## Features

* Creates a Secrets Manager secret.
* Supports a custom KMS key.
* Supports a single string secret.
* Supports JSON key-value secrets.
* Configurable recovery window.
* Standard project and environment tags.
* Does not expose the secret value through Terraform outputs.

## Basic Usage

```hcl
module "secrets" {
  source = "../../modules/secrets"

  project_name = "terraform-infrastructure"
  environment  = "dev"
}
```

This creates a secret similar to:

```text
terraform-infrastructure/dev/application
```

## JSON Secret

```hcl
module "secrets" {
  source = "../../modules/secrets"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  secret_values = {
    username = "application-user"
    password = "change-me"
  }
}
```

## Single Secret Value

```hcl
module "secrets" {
  source = "../../modules/secrets"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  secret_value = "change-me"
}
```

## KMS Encryption

```hcl
module "secrets" {
  source = "../../modules/secrets"

  project_name = "terraform-infrastructure"
  environment  = "production"

  kms_key_id = "arn:aws:kms:ap-south-1:123456789012:key/example"
}
```

## Important Security Note

Do not commit passwords, API keys, tokens, or other sensitive values into Git.

If a secret value is supplied directly through Terraform, protect the Terraform state because the normal Secrets Manager secret-version resource stores the secret value in Terraform state.

## Outputs

* `secret_id`
* `secret_arn`
* `secret_name`
* `secret_version_id`

The actual secret value is intentionally not exposed as an output.
