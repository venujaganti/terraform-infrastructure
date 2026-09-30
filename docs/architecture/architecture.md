# AWS Terraform Infrastructure Architecture

## 1. Overview

This repository manages AWS infrastructure using Terraform.

The infrastructure is organized into reusable modules and separate environment configurations.

Supported environments:

* Development
* Staging
* Production

The platform includes networking, security, compute, containers, Kubernetes, databases, storage, serverless services, DNS, CDN, monitoring, logging, secrets, backup, governance, testing, automation, and CI/CD.

---

## 2. High-Level Architecture

```text
                         Internet Users
                               |
                               v
                         Route 53 / DNS
                               |
                               v
                         CloudFront CDN
                               |
                               v
                         Load Balancer
                               |
                 +-------------+-------------+
                 |                           |
                 v                           v
              EC2 / ASG                   EKS
                 |                           |
                 +-------------+-------------+
                               |
             +-----------------+-----------------+
             |                 |                 |
             v                 v                 v
            RDS               S3                ECR
             |                 |                 |
             +-----------------+-----------------+
                               |
             +-----------------+-----------------+
             |                 |                 |
             v                 v                 v
          Lambda          API Gateway           SQS
             |                                   |
             +-----------------+-----------------+
                               |
                               v
                    CloudWatch / CloudTrail
                               |
                               v
                     Monitoring and Logging
```

---

## 3. Network Architecture

The networking layer provides:

* VPC
* Internet Gateway
* Public subnets
* Private subnets
* Public route table
* Private route tables
* Route table associations
* DNS support
* DNS hostnames

Logical architecture:

```text
                         VPC
                          |
             +------------+------------+
             |                         |
             v                         v
       Public Subnets            Private Subnets
             |                         |
             v                         +-------------+
       Load Balancer                   |             |
             |                         v             v
             v                        EC2           EKS
        Application                    |             |
                                       +------+------+
                                              |
                                              v
                                             RDS
```

Private resources should not be exposed directly to the public internet unless there is an explicit requirement.

---

## 4. Security Architecture

Security controls include:

* Security groups
* IAM roles
* IAM instance profiles
* IMDSv2 for EC2
* EBS encryption
* RDS encryption
* S3 encryption
* Secrets Manager
* CloudTrail
* CloudWatch
* VPC Flow Logs
* AWS Backup
* Terraform validation
* TFLint
* Trivy

Security-sensitive ports should use restricted source CIDR ranges.

Public SSH access is disabled by default in the security governance configuration.

---

## 5. Compute Architecture

The compute module supports EC2 workloads.

Default project configuration:

```text
Instance Type : m7i-flex.large
Root Volume   : 40 GiB
Volume Type   : gp3
Encryption    : Enabled
IMDSv2        : Required
```

The project references an existing AWS EC2 key pair by name instead of creating a duplicate key pair.

---

## 6. Auto Scaling and Load Balancing

The scalable application architecture is:

```text
                    Internet
                       |
                       v
                 CloudFront
                       |
                       v
                Load Balancer
                       |
             +---------+---------+
             |                   |
             v                   v
           EC2                 EC2
             |                   |
             +---------+---------+
                       |
                       v
                  Application
```

Auto Scaling can increase or decrease EC2 capacity based on configured scaling policies.

---

## 7. Container Architecture

The container platform uses Amazon ECR and Amazon EKS.

```text
Developer
    |
    v
Container Build
    |
    v
Amazon ECR
    |
    v
Amazon EKS
    |
    v
Managed Node Group
    |
    v
Application Pods
```

ECR provides container image storage and image lifecycle management.

---

## 8. Serverless Architecture

The serverless platform consists of API Gateway and Lambda.

```text
Client
  |
  v
API Gateway
  |
  v
Lambda
  |
  v
CloudWatch Logs
```

Amazon SQS provides asynchronous messaging and dead-letter queue support.

---

## 9. Database and Storage

Application data can use managed AWS storage services.

```text
Application
    |
    +--------> RDS
    |
    +--------> S3
    |
    +--------> Secrets Manager
```

Persistent storage should use encryption and appropriate backup policies.

---

## 10. DNS and CDN

The public delivery path is:

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

Route 53 provides DNS resolution.

CloudFront provides CDN delivery.

---

## 11. Monitoring and Logging

Monitoring services include:

* CloudWatch metrics
* CloudWatch alarms
* CloudWatch log groups
* CloudTrail
* VPC Flow Logs
* Application logs

Monitoring flow:

```text
AWS Resources
      |
      v
CloudWatch / CloudTrail
      |
      v
Logs + Metrics
      |
      v
Alarms
      |
      v
Operations
```

---

## 12. Backup Architecture

AWS Backup is used for supported resource backup requirements.

```text
AWS Resources
      |
      v
AWS Backup
      |
      v
Backup Vault
      |
      v
Recovery
```

Backup restoration should be tested periodically.

---

## 13. Secrets Management

Application secrets are managed through AWS Secrets Manager.

```text
Application
     |
     v
IAM Permission
     |
     v
Secrets Manager
     |
     v
Secret Value
```

Secret values must not be committed to Git.

---

## 14. Terraform Architecture

Reusable modules are located under:

```text
modules/
```

Environment configurations are located under:

```text
environments/
├── dev/
├── staging/
└── production/
```

The environments use the same Terraform structure while environment-specific values are supplied through `terraform.tfvars`.

---

## 15. Governance Architecture

Governance policies are located under:

```text
policies/
├── security/
├── compliance/
└── terraform/
```

The governance layer includes controls for:

* Network security
* Encryption
* IAM
* Resource tagging
* Logging
* Terraform versions
* Required tags

---

## 16. Testing Architecture

Testing is organized under:

```text
tests/
├── networking/
├── security/
├── compute/
├── database/
└── integration/
```

Testing is complemented by Terraform validation, formatting checks, TFLint, and Trivy security scanning.

---

## 17. CI/CD Architecture

```text
Developer
    |
    v
GitHub
    |
    v
Pull Request
    |
    +---- Terraform Format
    |
    +---- Terraform Validate
    |
    +---- TFLint
    |
    +---- Trivy
    |
    +---- Terraform Plan
    |
    v
Review
    |
    v
main branch
    |
    v
Terraform Apply
    |
    +---- dev
    |
    +---- staging
    |
    +---- production
```

Production deployments should use an approval-protected GitHub Environment.

---

## 18. Repository Architecture

```text
terraform-infrastructure/
│
├── accounts/
├── environments/
├── modules/
├── policies/
├── tests/
├── scripts/
├── docs/
│
├── .github/
│   └── workflows/
│
├── .terraform-version
├── .tflint.hcl
├── .terraform-docs.yml
├── Makefile
├── README.md
├── CHANGELOG.md
└── CONTRIBUTING.md
```

---

## 19. Design Principles

The project follows these principles:

1. Infrastructure as Code.
2. Reusable Terraform modules.
3. Environment separation.
4. Least-privilege IAM.
5. Encryption by default.
6. Restricted network access.
7. Automated validation.
8. Security scanning.
9. Controlled deployments.
10. Backup and recovery planning.
11. Consistent tagging.
12. Infrastructure documentation.
13. Repeatable deployments.
14. Separation of infrastructure and application concerns.
