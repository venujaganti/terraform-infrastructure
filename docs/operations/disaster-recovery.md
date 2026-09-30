# Disaster Recovery

## 1. Purpose

This document describes the recovery process for the AWS Terraform infrastructure.

Recovery areas include:

* Terraform infrastructure.
* EC2.
* EKS.
* RDS.
* S3.
* Secrets Manager.
* Route 53.
* CloudFront.
* Monitoring.
* Logging.
* Backup.

## 2. Recovery Flow

```text
Detect
  |
  v
Assess
  |
  v
Contain
  |
  v
Recover
  |
  v
Validate
  |
  v
Resume Service
  |
  v
Document
```

## 3. Terraform Recovery

Clone the repository:

```bash
git clone <repository-url>
cd terraform-infrastructure
```

Select the approved Git revision.

For production:

```bash
cd environments/production
```

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Generate a recovery plan:

```bash
terraform plan -var-file="terraform.tfvars"
```

Review the plan before applying.

## 4. EC2 Recovery

EC2 recovery may require:

* Terraform configuration.
* AMI.
* EBS volume.
* Security groups.
* IAM instance profile.
* Existing EC2 key pair.
* Application deployment.
* Secrets.

Recovery flow:

```text
Terraform
    |
    v
EC2 Infrastructure
    |
    v
Application
    |
    v
Health Check
```

## 5. Database Recovery

Database recovery should use the configured AWS backup mechanism.

Process:

1. Identify the failed database.
2. Identify the latest valid backup.
3. Determine the required recovery point.
4. Restore the database.
5. Verify connectivity.
6. Verify data.
7. Restore application connectivity.
8. Monitor the recovered database.

Do not delete the original database until recovery has been verified.

## 6. S3 Recovery

Verify:

* Bucket availability.
* Object availability.
* Encryption.
* IAM permissions.
* Application access.

Restore required objects using the configured recovery mechanism.

## 7. EKS Recovery

EKS infrastructure can be recreated using Terraform.

```text
Terraform
    |
    v
EKS Cluster
    |
    v
Managed Node Group
    |
    v
Kubernetes Workloads
    |
    v
Application
```

Kubernetes application manifests, Helm charts, container images, and required application configuration should be maintained as part of the application delivery process.

## 8. Secrets Recovery

Secrets are managed using AWS Secrets Manager.

Recovery steps:

1. Verify the secret exists.
2. Verify IAM permissions.
3. Verify application access.
4. Rotate credentials when required.
5. Verify application startup.

Never store secret values in Git.

## 9. DNS and CloudFront Recovery

The delivery path is:

```text
User
 |
 v
Route 53
 |
 v
CloudFront
 |
 v
Origin
 |
 v
Application
```

Verify:

* Route 53 records.
* DNS resolution.
* CloudFront distribution.
* Origin configuration.
* TLS certificate.
* Application health.

## 10. Monitoring Recovery

Verify:

* CloudWatch log groups.
* CloudWatch metrics.
* CloudWatch alarms.
* CloudTrail.
* VPC Flow Logs.
* Application logs.

Monitoring should be restored before declaring the environment operational.

## 11. Backup Verification

Backups should periodically be tested through restoration exercises.

Verify:

* Backup availability.
* Restore capability.
* Data integrity.
* Application connectivity.
* IAM permissions.
* Recovery time.

A successful backup job does not by itself prove that recovery will work.

## 12. Recovery Checklist

### Infrastructure

* [ ] Repository available.
* [ ] Correct Git revision identified.
* [ ] AWS credentials available.
* [ ] Terraform initialized.
* [ ] Terraform validation successful.
* [ ] Recovery plan reviewed.

### Data

* [ ] Database backup identified.
* [ ] Database restored.
* [ ] Database data verified.
* [ ] S3 data verified.
* [ ] Secrets verified.

### Application

* [ ] EC2 recovered.
* [ ] EKS recovered where required.
* [ ] Application deployed.
* [ ] Health checks pass.
* [ ] Load balancer healthy.

### Delivery

* [ ] Route 53 works.
* [ ] DNS resolves.
* [ ] CloudFront works.
* [ ] TLS works.

### Operations

* [ ] CloudWatch metrics available.
* [ ] Logs available.
* [ ] CloudWatch alarms available.
* [ ] CloudTrail activity available.

## 13. Recovery Completion

Recovery is complete after:

1. Infrastructure is healthy.
2. Application functionality is verified.
3. Data is verified.
4. DNS and CloudFront are verified.
5. Monitoring is operational.
6. Required stakeholders are informed.
7. Recovery actions are documented.
