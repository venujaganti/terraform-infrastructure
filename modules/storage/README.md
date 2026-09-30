# Storage Module

This module creates a secure Amazon S3 bucket for application storage.

## Resources

The module creates:

- S3 bucket
- S3 ownership controls
- S3 public access block
- S3 versioning configuration
- S3 server-side encryption configuration

## Security

The bucket is configured with:

- Public access blocked
- Bucket owner enforced
- Server-side encryption
- Optional versioning
- Optional object lock
- No public ACLs
- No public bucket policy

## Default Configuration

| Setting | Default |
|---|---|
| Versioning | Enabled |
| Encryption | AES256 |
| Public access | Blocked |
| Object ownership | Bucket owner enforced |
| Force destroy | `false` |
| Object Lock | `false` |

## Example

```hcl
module "storage" {
  source = "../../modules/storage"

  project_name = var.project_name
  environment  = var.environment

  bucket_name = null

  versioning_enabled = true

  force_destroy = false
}