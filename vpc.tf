# Creating a Virtual Private Cloud (VPC)
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # CIDR block for the VPC

  # Adding tags to the VPC for identification
  tags = {
    Name = "MyVPC"  # Tag for the VPC
    # You can add any other desired tags here
  }
}

# Creating Subnet A within the VPC
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.my_vpc.id  # Associating the subnet with the specified VPC
  cidr_block        = "10.0.1.0/24"  # CIDR block for the first subnet
  availability_zone = "${var.aws_region}a"  # Availability zone for Subnet A

  # Adding tags to Subnet A for identification
  tags = {
    Name = "SubnetA"  # Tag for Subnet A
  }
}

# Creating Subnet B within the VPC
resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id  # Associating the subnet with the specified VPC
  cidr_block        = "10.0.2.0/24"  # CIDR block for the second subnet
  availability_zone = "${var.aws_region}b"  # Availability zone for Subnet B

  # Adding tags to Subnet B for identification
  tags = {
    Name = "SubnetB"  # Tag for Subnet B
  }
}

# Outputting the VPC ID for reference
output "vpc_id" {
  value = aws_vpc.my_vpc.id  # Outputting the ID of the created VPC
}

# Outputting the Subnet IDs for reference
output "subnet_ids" {
  value = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]  # Outputting the IDs of Subnet A and Subnet B
}
