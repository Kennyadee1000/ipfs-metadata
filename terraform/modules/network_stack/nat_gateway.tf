resource "aws_eip" "nat_eip_a" {
  tags = {
    Name = "eip-nat-gateway-a"
  }
}

resource "aws_eip" "nat_eip_b" {
  tags = {
    Name = "eip-nat-gateway-b"
  }
}

resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_eip_a.allocation_id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags          = {
    Name = "nat-gateway-a"
  }
}

resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.nat_eip_b.allocation_id
  subnet_id     = aws_subnet.public_subnet_b.id
  tags          = {
    Name = "nat-gateway-b"
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

resource "aws_route_table" "nat_b_route_table" {
  depends_on = [
    aws_vpc.base_vpc,
    aws_nat_gateway.nat_gateway_b,
  ]

  vpc_id = aws_vpc.base_vpc.id
  tags = {
    Name = "nat-gateway-b-rtb"
  }
}

resource "aws_route" "nat_gateway_a_internet_route" {
  route_table_id         = aws_route_table.nat_a_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_a.id
}

resource "aws_route" "nat_gateway_b_internet_route" {
  route_table_id         = aws_route_table.nat_b_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_b.id
}

resource "aws_route_table_association" "route_a_private_subnet_association" {
  depends_on = [
    aws_subnet.private_subnet_a,
    aws_route_table.nat_a_route_table,
  ]
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.nat_a_route_table.id
}

resource "aws_route_table_association" "route_b_private_subnet_association" {
  depends_on = [
    aws_subnet.private_subnet_b,
    aws_route_table.nat_b_route_table,
  ]
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.nat_b_route_table.id
}