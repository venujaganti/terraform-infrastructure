# Deployment Operations

## 1. Overview

Terraform infrastructure is deployed using automated validation and controlled deployment procedures.

Deployment flow:

```text
Format
   |
   v
Validate
   |
   v
Security Scan
   |
   v
Plan
   |
   v
Review
   |
   v
Apply
   |
   v
Verify
```

## 2. Prerequisites

Verify Terraform:

```bash
terraform version
```

The repository currently targets Terraform:

```text
>= 1.9.0
< 2.0.0
```

The repository's pinned development version is:

```text
1.9.8
```

Verify AWS identity:

```bash
aws sts get-caller-identity
```

## 3. Format

```bash
./scripts/format.sh
```

## 4. Validate

```bash
./scripts/validate.sh
```

## 5. Security Scan

```bash
./scripts/security-scan.sh
```

## 6. Development

Plan:

```bash
./scripts/plan.sh dev
```

Apply:

```bash
./scripts/apply.sh dev
```

## 7. Staging

Plan:

```bash
./scripts/plan.sh staging
```

Apply:

```bash
./scripts/apply.sh staging
```

## 8. Production

Plan:

```bash
./scripts/plan.sh production
```

Review the plan carefully.

Apply:

```bash
./scripts/apply.sh production
```

Production deployment should follow the repository's approval process.

## 9. Pre-Deployment Checklist

* [ ] Code reviewed.
* [ ] Terraform formatted.
* [ ] Terraform validated.
* [ ] Security scan passed.
* [ ] Terraform plan reviewed.
* [ ] AWS account verified.
* [ ] Environment verified.
* [ ] Required variables configured.
* [ ] No unexpected destructive changes.
* [ ] Backup requirements considered.

## 10. Post-Deployment Checklist

* [ ] Terraform apply successful.
* [ ] Application accessible.
* [ ] Load balancer healthy.
* [ ] DNS resolution successful.
* [ ] CloudFront delivery successful.
* [ ] CloudWatch metrics available.
* [ ] CloudWatch alarms available.
* [ ] CloudTrail activity available.
* [ ] Logs available.
* [ ] Backup configuration available.

## 11. Deployment Failure

If deployment fails:

1. Read the Terraform error.
2. Identify the affected resource.
3. Determine the root cause.
4. Correct the configuration or permissions.
5. Run validation.
6. Generate a new plan.
7. Review the new plan.
8. Apply the corrected configuration.

Do not repeatedly apply Terraform without understanding the failure.
