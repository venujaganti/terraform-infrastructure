output "cluster_id" {
  description = "ID of the EKS cluster."
  value       = aws_eks_cluster.this.id
}

output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster."
  value       = aws_eks_cluster.this.version
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded Kubernetes cluster certificate authority data."
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "Security group ID created for the EKS control plane."
  value       = aws_security_group.cluster.id
}

output "cluster_role_name" {
  description = "IAM role name used by the EKS control plane."
  value       = aws_iam_role.eks_cluster.name
}

output "cluster_role_arn" {
  description = "IAM role ARN used by the EKS control plane."
  value       = aws_iam_role.eks_cluster.arn
}

output "node_group_id" {
  description = "ID of the EKS managed node group."
  value       = aws_eks_node_group.this.id
}

output "node_group_name" {
  description = "Name of the EKS managed node group."
  value       = aws_eks_node_group.this.node_group_name
}

output "node_role_name" {
  description = "IAM role name used by EKS worker nodes."
  value       = aws_iam_role.eks_node.name
}

output "node_role_arn" {
  description = "IAM role ARN used by EKS worker nodes."
  value       = aws_iam_role.eks_node.arn
}