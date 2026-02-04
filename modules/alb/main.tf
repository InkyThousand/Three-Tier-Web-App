# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.environment}-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "app" {
  name     = "${var.environment}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true    # Enable health checks
    healthy_threshold   = 2       # Number of consecutive successful checks to mark healthy
    interval            = 30      # Time between health checks (seconds)
    matcher             = "200"    # HTTP status code that indicates healthy response
    path                = "/"      # URL path to check for health
    port                = "traffic-port"  # Use same port as target group traffic
    protocol            = "HTTP"   # Protocol for health checks
    timeout             = 5       # Time to wait for response (seconds)
    unhealthy_threshold = 2       # Number of consecutive failed checks to mark unhealthy
  }

  tags = {
    Name = "${var.environment}-app-tg"
  }
}

# Listener - Defines how ALB handles incoming requests
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.main.arn  # Which ALB this listener belongs to
  port              = "80"             # Port to listen on for incoming traffic
  protocol          = "HTTP"           # Protocol to use (HTTP/HTTPS)

  default_action {
    type             = "forward"                    # Action type: forward traffic
    target_group_arn = aws_lb_target_group.app.arn # Where to send the traffic
  }
}