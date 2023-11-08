# Creating a route table associated with a VPC
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id  # Associating the route table with the specified VPC

  # Adding tags to the route table for identification
  tags = {
    Name = "my_route_table"  # Tag for easy identification of the route table
  }
}

# Creating a custom route within the route table to an internet gateway
resource "aws_route" "custom_route" {
  route_table_id         = aws_route_table.my_route_table.id  # Associating the route with the created route table
  destination_cidr_block = "0.0.0.0/0"  # Destination CIDR block for the route (all internet traffic)
  gateway_id             = aws_internet_gateway.my_igw.id  # Specifying the internet gateway for the route
}

# Outputting the ID of the route table for reference
output "route_table_id" {
  value = aws_route_table.my_route_table.id  # Outputting the ID of the created route table
}