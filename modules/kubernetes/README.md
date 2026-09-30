# Kubernetes Module

This module creates an Amazon Elastic Kubernetes Service (EKS) cluster with a managed EC2 node group.

## Resources

The module creates:

- EKS cluster
- EKS cluster IAM role
- EKS cluster security group
- EKS managed node group
- EKS worker-node IAM role
- Required AWS-managed IAM policy attachments
- EKS control plane logging

## Architecture

```text
                    Amazon EKS
                        |
             ┌──────────┴──────────┐
             |                     |
        Control Plane         Managed Nodes
             |                     |
             |              ┌──────┴──────┐
             |              |             |
             v              v             v
         Kubernetes      Worker #1    Worker #2
         API Server