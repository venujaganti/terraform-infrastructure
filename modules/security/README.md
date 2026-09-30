# Security Module

Reusable Terraform module for application security groups.

## Resources

The module creates:

* One VPC security group
* SSH ingress rule
* HTTP ingress rule
* HTTPS ingress rule
* Jenkins ingress rule
* Kubernetes API ingress rule
* Kubernetes kubelet ingress rule
* IPv4 egress rule

## Ports

| Service            |  Port |
| ------------------ | ----: |
| SSH                |    22 |
| HTTP               |    80 |
| HTTPS              |   443 |
| Jenkins            |  8080 |
| Kubernetes API     |  6443 |
| Kubernetes Kubelet | 10250 |

## Security

SSH and Jenkins access are restricted by default.

The caller must explicitly provide trusted CIDR blocks.

## Example

```hcl
module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.networking.vpc_id

  ssh_allowed_cidr_blocks = [
    "203.0.113.10/32"
  ]

  jenkins_allowed_cidr_blocks = [
    "203.0.113.10/32"
  ]

  http_allowed_cidr_blocks = [
    "0.0.0.0/0"
  ]

  https_allowed_cidr_blocks = [
    "0.0.0.0/0"
  ]
}
```

Replace the example IP address with an actual trusted CIDR before deployment.
