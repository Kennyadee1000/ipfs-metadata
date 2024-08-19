resource "aws_eip" "nat_eip_a" {
  tags = {
    Name = "eip-nat-gateway-a"
  }
}

resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_eip_a.allocation_id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags          = {
    Name = "nat-gateway-a"
  }
}

resource "aws_route_table" "nat_a_route_table" {
  depends_on = [
    aws_vpc.base_vpc,
    aws_nat_gateway.nat_gateway_a,
  ]

  vpc_id = aws_vpc.base_vpc.id
  tags = {
    Name = "nat-gateway-a-rtb"
  }
}

resource "aws_route" "nat_gateway_a_internet_route" {
  route_table_id         = aws_route_table.nat_a_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_a.id
}

resource "aws_route_table_association" "route_a_private_subnet_association" {
  depends_on = [
    aws_subnet.private_subnet_a,
    aws_route_table.nat_a_route_table,
  ]
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.nat_a_route_table.id
}