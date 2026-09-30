# Auto Scaling Module

This module creates an AWS EC2 Launch Template and Auto Scaling Group.

## Features

- EC2 Launch Template
- Auto Scaling Group
- Multiple Availability Zone support
- Existing EC2 key pair support
- IAM instance profile support
- Security group support
- Configurable minimum, desired, and maximum capacity
- Application Load Balancer target group integration
- ELB health checks
- Rolling instance refresh
- Encrypted gp3 root EBS volume
- IMDSv2 required
- Optional detailed monitoring
- Common resource tags

## Default Configuration

| Setting | Default |
|---|---|
| Instance type | `m7i-flex.large` |
| Root volume | `40 GiB` |
| Root volume type | `gp3` |
| Minimum instances | `2` |
| Desired instances | `2` |
| Maximum instances | `4` |
| Health check | `ELB` |
| Detailed monitoring | `false` |

## Dependencies

This module expects:

- Networking module
- Security module
- Identity module
- Load Balancer module
- Compatible AWS AMI

## Example

```hcl
module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name = var.project_name
  environment  = var.environment

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_ids = module.networking.public_subnet_ids

  security_group_ids = [
    module.security.security_group_id
  ]

  iam_instance_profile_name = module.identity.instance_profile_name

  key_name = var.key_name

  target_group_arns = [
    module.load_balancer.target_group_arn
  ]

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  root_volume_size = 40
  root_volume_type = "gp3"
}