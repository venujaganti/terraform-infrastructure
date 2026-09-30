resource "aws_security_group" "main" {
  name        = "${local.name_prefix}-sg"
  description = "Security group for ${local.name_prefix}"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each = toset(var.ssh_allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  description = "SSH access"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  for_each = toset(var.http_allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"

  description = "HTTP access"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  for_each = toset(var.https_allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

  description = "HTTPS access"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins" {
  for_each = toset(var.jenkins_allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  from_port         = 8080
  to_port           = 8080
  ip_protocol       = "tcp"

  description = "Jenkins access"
}

resource "aws_vpc_security_group_ingress_rule" "kubernetes_api" {
  for_each = toset(var.kubernetes_api_allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  from_port         = 6443
  to_port           = 6443
  ip_protocol       = "tcp"

  description = "Kubernetes API access"
}

resource "aws_vpc_security_group_ingress_rule" "kubernetes_nodes" {
  for_each = toset(var.kubernetes_node_allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  from_port         = 10250
  to_port           = 10250
  ip_protocol       = "tcp"

  description = "Kubernetes kubelet communication"
}

resource "aws_vpc_security_group_egress_rule" "all_ipv4" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  description = "Allow outbound IPv4 traffic"
}