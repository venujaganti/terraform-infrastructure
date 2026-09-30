# Logging Module

This module creates CloudWatch Logs groups for application, system, and audit logging.

## Features

* Application log group.
* System log group.
* Audit log group.
* Configurable retention periods.
* Optional KMS encryption.
* Optional log preservation during Terraform destroy.
* Standard project and environment tags.

## Usage

```hcl
module "logging" {
  source = "../../modules/logging"

  project_name = "terraform-infrastructure"
  environment  = "dev"

  application_log_retention_days = 30
  system_log_retention_days      = 30
  audit_log_retention_days       = 90
}
```

## Default Log Groups

The module creates:

```text
/terraform-infrastructure/dev/application
/terraform-infrastructure/dev/system
/terraform-infrastructure/dev/audit
```

For staging:

```text
/terraform-infrastructure/staging/application
/terraform-infrastructure/staging/system
/terraform-infrastructure/staging/audit
```

For production:

```text
/terraform-infrastructure/production/application
/terraform-infrastructure/production/system
/terraform-infrastructure/production/audit
```

## KMS Encryption

An existing KMS key can be supplied:

```hcl
module "logging" {
  source = "../../modules/logging"

  project_name = "terraform-infrastructure"
  environment  = "production"

  kms_key_id = "arn:aws:kms:ap-south-1:123456789012:key/example"
}
```

## Preserve Logs

To keep logs after Terraform destroys the log groups:

```hcl
skip_destroy = true
```

## Outputs

* `application_log_group_name`
* `application_log_group_arn`
* `system_log_group_name`
* `system_log_group_arn`
* `audit_log_group_name`
* `audit_log_group_arn`
