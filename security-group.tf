# Creating an AWS Security Group
resource "aws_security_group" "my_sg" {
  name        = "my_sg"             # Name of the security group
  description = "Allow incoming traffic on port 80"  # Description for the security group
  vpc_id      = aws_vpc.my_vpc.id   # Associating the security group with the specified VPC

  # Ingress rule to allow incoming traffic on port 80 (HTTP)
  ingress {
    from_port   = 80       # Source port for incoming traffic
    to_port     = 80       # Destination port for incoming traffic
    protocol    = "tcp"    # Protocol (in this case, TCP for HTTP)
    cidr_blocks = ["0.0.0.0/0"]  # Allowing incoming traffic from any source IP (0.0.0.0/0)
    # You might want to restrict the source IP range for better security
    # Example: cidr_blocks = ["YOUR_IP_ADDRESS/32"]
  }

  # Adding tags to the security group for identification
  tags = {
    Name = "my_sg"  # Tag for easy identification of the security group
  }
}
