# Creating an Application Load Balancer (ALB)
resource "aws_alb" "my_alb" {
  name                       = "my_alb"  # Name of the Application Load Balancer
  internal                   = false     # Specifies whether the ALB is internal or external
  load_balancer_type         = "application"  # Type of the load balancer
  subnets                    = [aws_subnet.subnet_a, aws_subnet.subnet_b]  # Subnets for the ALB
  enable_deletion_protection = false     # Whether deletion protection is enabled
}

# Creating a listener for the ALB
resource "aws_alb_listener" "my_listener" {
  load_balancer_arn = aws_alb.my_alb.arn  # ARN (Amazon Resource Name) of the ALB
  port              = "80"  # Port the ALB listens on
  protocol          = "HTTP"  # Protocol used by the listener
  default_action {
    target_group_arn = aws_alb_target_group.my_tg.arn  # ARN of the target group for routing traffic
    type             = "forward"  # Type of action - forwarding the request to the target group
  }
}

# Creating a target group for the ALB
resource "aws_alb_target_group" "my_tg" {
  name     = "my_tg"  # Name of the target group
  port     = var.target_group_port  # Port for the target group
  protocol = "HTTP"  # Protocol used by the target group
  vpc_id   = aws_vpc.my_vpc.id  # VPC ID where the target group resides
}

# Attaching the ALB target group to an autoscaling group
resource "aws_lb_target_group_attachment" "my_lb_attch" {
  target_group_arn = aws_alb_target_group.my_tg.arn  # ARN of the target group to attach
  target_id        = aws_autoscaling_group.my_asg.id  # ID of the target (Autoscaling Group)
}

# Outputting the ALB DNS name
output "alb_dns_name" {
  value = aws_alb.my_alb.name  # DNS name of the ALB
}