resource "aws_lb" "this" {
  name               = "${local.name_prefix}-alb"
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = var.security_group_ids
  subnets         = var.subnet_ids

  enable_deletion_protection = var.deletion_protection

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb"
    }
  )
}

resource "aws_lb_target_group" "this" {
  name        = "${local.name_prefix}-tg"
  port        = var.target_port
  protocol    = var.target_protocol
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    matcher             = "200-399"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-target-group"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-http-listener"
    }
  )
}