# Terraform Infrastructure

Infrastructure as Code project for building and managing AWS infrastructure with Terraform.

## Project Structure

```text
terraform-infrastructure/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── production/
├── modules/
│   ├── networking/
│   ├── security/
│   ├── identity/
│   ├── compute/
│   ├── autoscaling/
│   ├── load-balancer/
│   ├── database/
│   ├── storage/
│   ├── container/
│   ├── kubernetes/
│   ├── serverless/
│   ├── api-gateway/
│   ├── messaging/
│   ├── monitoring/
│   ├── logging/
│   ├── dns/
│   ├── cdn/
│   ├── secrets/
│   └── backup/
├── accounts/
├── global/
├── policies/
├── tests/
├── scripts/
├── docs/
├── .github/workflows/
└── .devcontainer/
```

## Purpose

This repository provides reusable Terraform modules and environment-specific Terraform root configurations for AWS infrastructure.

## Environments

- Development: `environments/dev`
- Staging: `environments/staging`
- Production: `environments/production`

## Terraform Version

The repository is pinned to Terraform `1.9.8` through `.terraform-version`.

## AWS Region

The current environment defaults use `ap-south-1`.

## Validation

Validate each Terraform environment with:

```bash
make validate
```

Or validate a specific environment:

```bash
cd environments/dev
terraform init -backend=false
terraform validate
```

## Formatting

```bash
make fmt
```

## Security Checks

```bash
./scripts/security-scan.sh
```

## Deployment

Use the environment deployment scripts:

```bash
./scripts/plan.sh dev
./scripts/apply.sh dev
```

For staging or production, replace `dev` with the required environment.

## Important

The `environments/*` directories are the Terraform root configurations. The directories under `modules/`, `global/`, `accounts/`, and `policies/` contain reusable or independently managed Terraform configurations.

Do not commit AWS credentials, private keys, Terraform state files, passwords, or other secrets.
