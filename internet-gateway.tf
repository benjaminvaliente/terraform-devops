resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_igw.id
}