resource "aws_iam_role" "eks_cluster" {
  name               = "${local.name_prefix}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-cluster-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_node" {
  name               = "${local.name_prefix}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-node-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_container_registry_read_only" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

resource "aws_security_group" "cluster" {
  name        = "${local.name_prefix}-eks-cluster-sg"
  description = "Security group for the ${local.name_prefix} EKS cluster."
  vpc_id      = data.aws_subnet.selected[local.first_subnet_id].vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-cluster-sg"
    }
  )
}

resource "aws_vpc_security_group_egress_rule" "cluster_all_ipv4" {
  security_group_id = aws_security_group.cluster.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  description = "Allow outbound IPv4 traffic."
}

resource "aws_eks_cluster" "this" {
  name     = "${local.name_prefix}-eks"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.cluster_version

  enabled_cluster_log_types = var.cluster_log_types

  vpc_config {
    subnet_ids = var.subnet_ids

    security_group_ids = concat(
      [aws_security_group.cluster.id],
      var.cluster_security_group_ids
    )

    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks"
    }
  )
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${local.name_prefix}-node-group"
  node_role_arn   = aws_iam_role.eks_node.arn

  subnet_ids = local.eks_node_subnet_ids

  instance_types = var.node_instance_types
  capacity_type  = var.node_capacity_type

  scaling_config {
    min_size     = var.node_min_size
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_container_registry_read_only
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-node"
    }
  )
}