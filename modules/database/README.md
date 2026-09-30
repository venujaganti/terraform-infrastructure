# Database Module

This module creates a private Amazon RDS PostgreSQL database.

## Resources

The module creates:

- RDS PostgreSQL instance
- RDS DB subnet group
- Encrypted database storage
- Automated backups
- CloudWatch PostgreSQL and upgrade log exports
- AWS-managed master password through Secrets Manager

## Security

The database is configured with:

- `publicly_accessible = false`
- Encrypted storage
- Private subnet deployment
- Security group support
- AWS-managed master password
- Automated backups
- Optional Multi-AZ deployment

## Default Configuration

| Setting | Default |
|---|---|
| Engine | PostgreSQL |
| Engine version | `17` |
| Instance class | `db.t4g.micro` |
| Storage | `20 GiB` |
| Storage type | `gp3` |
| Maximum storage | `100 GiB` |
| Port | `5432` |
| Database name | `appdb` |
| Master username | `appadmin` |
| Multi-AZ | `false` |
| Public access | `false` |
| Backup retention | `7 days` |
| Deletion protection | `false` |

## Example

```hcl
module "database" {
  source = "../../modules/database"

  project_name = var.project_name
  environment  = var.environment

  subnet_ids = module.networking.private_subnet_ids

  security_group_ids = [
    module.security.security_group_id
  ]

  engine         = "postgres"
  engine_version = "17"

  instance_class = "db.t4g.micro"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"

  database_name = "appdb"

  master_username = "appadmin"

  port = 5432

  backup_retention_period = 7

  multi_az = false
}