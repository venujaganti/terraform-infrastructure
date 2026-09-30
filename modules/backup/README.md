# Backup Module

This module configures AWS Backup for scheduled backups.

## Features

* AWS Backup vault.
* AWS Backup plan.
* Scheduled backup rule.
* Backup lifecycle retention.
* AWS Backup IAM role.
* Tag-based resource selection.
* Optional Backup Vault Lock.
* Standard project and environment tags.

## Basic Usage

```hcl
module "backup" {
  source = "../../modules/backup"

  project_name = "terraform-infrastructure"
  environment  = "dev"
}
```

## Resource Selection

The default selection looks for:

```text
Backup = true
```

Resources with this tag are included in the backup plan.

For example:

```hcl
tags = {
  Backup = "true"
}
```

## Custom Schedule

The default schedule is:

```text
cron(0 5 * * ? *)
```

This represents a daily AWS Backup schedule.

Example:

```hcl
module "backup" {
  source = "../../modules/backup"

  project_name = "terraform-infrastructure"
  environment  = "production"

  schedule = "cron(0 2 * * ? *)"
}
```

## Retention

Default settings:

```text
Cold storage: disabled
Deletion:     30 days
```

Example:

```hcl
module "backup" {
  source = "../../modules/backup"

  project_name = "terraform-infrastructure"
  environment  = "production"

  cold_storage_after_days = 30
  delete_after_days       = 365
}
```

## Backup Vault Lock

Vault Lock is optional:

```hcl
module "backup" {
  source = "../../modules/backup"

  project_name = "terraform-infrastructure"
  environment  = "production"

  enable_vault_lock = true

  vault_lock_min_retention_days = 30
  vault_lock_max_retention_days = 365
}
```

Vault Lock should be enabled only after the retention requirements have been reviewed because it is designed to protect recovery points from premature deletion.

## Outputs

* `backup_vault_id`
* `backup_vault_arn`
* `backup_vault_name`
* `backup_plan_id`
* `backup_plan_arn`
* `backup_plan_name`
* `backup_role_arn`
* `backup_selection_id`
* `vault_lock_enabled`
