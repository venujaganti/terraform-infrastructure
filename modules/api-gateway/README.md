# API Gateway Module

This module creates an Amazon API Gateway HTTP API integrated with AWS Lambda.

## Resources

The module creates:

- API Gateway HTTP API
- Lambda proxy integration
- API route
- Default stage
- Lambda invoke permission
- Optional CloudWatch access logging

## Architecture

```text
Client
  |
  v
API Gateway HTTP API
  |
  v
Lambda