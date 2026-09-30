# Container Module

This module creates an Amazon Elastic Container Registry (ECR) repository for application container images.

## Resources

The module creates:

- ECR repository
- ECR image scanning configuration
- ECR encryption
- ECR lifecycle policy

## Security

The repository uses:

- Server-side encryption
- Image scanning on push
- Configurable tag mutability
- Lifecycle cleanup
- No public repository configuration

## Default Configuration

| Setting | Default |
|---|---|
| Image tag mutability | `MUTABLE` |
| Scan on push | `true` |
| Encryption | `AES256` |
| Images retained | `20` |
| Force delete | `false` |

## Example

```hcl
module "container" {
  source = "../../modules/container"

  project_name = var.project_name
  environment  = var.environment

  repository_name = null

  image_tag_mutability = "MUTABLE"

  scan_on_push = true

  force_delete = false
}