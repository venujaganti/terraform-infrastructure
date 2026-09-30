# Compute Module

Reusable Terraform module for deploying an AWS EC2 instance.

## Resources

This module creates:

* EC2 instance
* Encrypted root EBS volume
* IMDSv2 configuration

## Default Configuration

| Setting                | Value               |
| ---------------------- | ------------------- |
| Instance type          | `m7i-flex.large`    |
| Root volume            | `40 GiB`            |
| Root volume type       | `gp3`               |
| Root volume encryption | Enabled             |
| IMDSv2                 | Required            |
| Public IP              | Enabled by default  |
| Detailed monitoring    | Disabled by default |

## Dependencies

The module expects values from other modules:

```text
Networking
    │
    └── subnet_id
          │
          ▼
Security
    │
    └── security_group_ids
          │
          ▼
Identity
    │
    └── iam_instance_profile_name
          │
          ▼
Compute
    │
    └── EC2
```

## Example

```hcl
module "compute" {
  source = "../../modules/compute"

  project_name = var.project_name
  environment  = var.environment

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_id = module.networking.public_subnet_ids[0]

  security_group_ids = [
    module.security.security_group_id
  ]

  key_name = var.key_name

  iam_instance_profile_name = module.identity.instance_profile_name

  associate_public_ip_address = true

  root_volume_size = 40
  root_volume_type = "gp3"
}
```

## Security

The root EBS volume is encrypted.

IMDSv2 is required to reduce exposure to metadata-based credential attacks.

The module does not create or store private SSH keys.

The AWS key pair must already exist in the target AWS region.

## Important

The `ami_id` must be compatible with the selected AWS region and instance type.

Do not place private keys, passwords, or AWS credentials in Terraform variables.
