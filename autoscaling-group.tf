# Creating a launch configuration for an Auto Scaling Group
resource "aws_launch_configuration" "my_launch_config" {
  name            = "my_launch_config" # Name of the launch configuration
  image_id        = "ami-xxxxxxxxx"    # AMI ID for the instances
  instance_type   = "t2.micro"        # Instance type for the instances
  key_name        = "my_key_pair"     # Key pair name for SSH access
  security_groups = [aws_security_group.my_sg] # Security group for the instances

  # Ensure the new launch configuration is created before the old one is destroyed
  lifecycle {
    create_before_destroy = true
  }
}

# Creating an Auto Scaling Group
resource "aws_autoscaling_group" "my_asg" {
  desired_capacity     = 2                            # Desired number of instances
  max_size             = 5                            # Maximum number of instances
  min_size             = 2                            # Minimum number of instances
  health_check_type    = "EC2"                        # Health check type
  force_delete         = true                         # Force delete on update
  name                 = "my-asg"                     # Name of the Auto Scaling Group
  launch_configuration = aws_launch_configuration.my_launch_config.id # Reference to launch configuration

  vpc_zone_identifier = [aws_subnet.subnet_a, aws_subnet.subnet_b] # Subnets where instances should be launched

  # Defining an initial lifecycle hook for instance launching
  initial_lifecycle_hook {
    name                 = "initial"
    default_result       = "ABANDON"
    heartbeat_timeout    = 300
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }

  # Ensure the new Auto Scaling Group is created before the old one is destroyed
  lifecycle {
    create_before_destroy = true
  }
}

# Creating an Auto Scaling Policy
resource "aws_autoscaling_policy" "my_asg_policy" {
  name                   = "scale-up"                                # Name of the scaling policy
  scaling_adjustment     = 1                                        # Scaling adjustment value
  adjustment_type        = "ChangeInCapacity"                       # Type of adjustment
  cooldown               = 300                                      # Cooldown period
  policy_type            = "SimpleScaling"                          # Type of policy
  autoscaling_group_name = aws_autoscaling_group.my_asg.name        # Reference to Auto Scaling Group
}

# Creating a schedule for the Auto Scaling Group
resource "aws_autoscaling_schedule" "my_asg_schedule" {
  scheduled_action_name  = "scale-up-at-peak-times"                 # Name of the scheduled action
  desired_capacity       = 5                                        # Desired capacity during the scheduled action
  min_size               = 2                                        # Minimum size during the scheduled action
  max_size               = 5                                        # Maximum size during the scheduled action
  recurrence             = "0 9 * * MON-FRI"                        # Recurrence schedule (e.g., every weekday at 9 AM)
  autoscaling_group_name = aws_autoscaling_group.my_asg.name        # Reference to Auto Scaling Group
}

# Output the Auto Scaling Group name
output "autoscaling_group_name" {
  value = aws_autoscaling_group.my_asg.id  # Output the Auto Scaling Group's ID
}