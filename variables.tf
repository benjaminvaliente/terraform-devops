# Defines a variable for AWS region
variable "aws_region" {
  description = "AWS region where VPC will be created"  # Description of the variable
  default     = "us-east-1"  # Default value if not explicitly set
}

# Defines a variable for the target group port used by ALB
variable "target_group_port" {
  description = "Port for the ALB target group"  # Description of the variable
  # No default value set, needs to be explicitly provided when used
}
