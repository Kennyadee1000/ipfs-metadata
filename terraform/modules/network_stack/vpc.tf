resource "aws_vpc" "base_vpc" {

  cidr_block                       = "10.${var.vpc_subnet_number}.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_support               = true
  enable_dns_hostnames             = true
  tags                             = {
    Name     = "baseVpc-${var.environment}"
    Deployer = "terraform"
    Project  = "Infrastructure"
    Customer = var.customer

  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.base_vpc.id
  tags   = {
    Name     = "baseVpc-${var.environment}-igw"
    Deployer = "terraform"
    Project  = "Infrastructure"
    Customer = var.customer
  }
}


resource "aws_subnet" "public_subnet_a" {

  vpc_id                  = aws_vpc.base_vpc.id
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  cidr_block              = "10.${var.vpc_subnet_number}.0.0/20"
  ipv6_cidr_block         = cidrsubnets(aws_vpc.base_vpc.ipv6_cidr_block, 8, 8, 8, 8)[0]
  map_public_ip_on_launch = true

  tags = {
    Name                                                 = "Public A"
    Reach                                                = "public"
  }
}

resource "aws_subnet" "public_subnet_b" {

  vpc_id                  = aws_vpc.base_vpc.id
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  cidr_block              = "10.${var.vpc_subnet_number}.32.0/20"
  ipv6_cidr_block         = cidrsubnets(aws_vpc.base_vpc.ipv6_cidr_block, 8, 8, 8, 8)[2]
  map_public_ip_on_launch = true

  tags = {
    Name                                                 = "Public B"
    Reach                                                = "public"
  }
}


resource "aws_subnet" "private_subnet_a" {
  vpc_id                          = aws_vpc.base_vpc.id
  availability_zone               = data.aws_availability_zones.available_zones.names[0]
  cidr_block                      = "10.${var.vpc_subnet_number}.16.0/20"
  ipv6_cidr_block                 = cidrsubnets(aws_vpc.base_vpc.ipv6_cidr_block, 8, 8, 8, 8)[1]
  assign_ipv6_address_on_creation = false

  tags = {
    Name                                                 = "Private A"
    Reach                                                = "private"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                          = aws_vpc.base_vpc.id
  availability_zone               = data.aws_availability_zones.available_zones.names[1]
  cidr_block                      = "10.${var.vpc_subnet_number}.48.0/20"
  ipv6_cidr_block                 = cidrsubnets(aws_vpc.base_vpc.ipv6_cidr_block, 8, 8, 8, 8)[3]
  assign_ipv6_address_on_creation = false

  tags = {
    Name                                                 = "Private B"
    Reach                                                = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base_vpc.id


  tags = {
    Name = "Public-rtb"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}


resource "aws_network_acl" "network_acl_public" {
  vpc_id = aws_vpc.base_vpc.id
  tags   = {
    Name = "Public-nacl"
  }
}

resource "aws_network_acl" "network_acl_private" {
  vpc_id = aws_vpc.base_vpc.id
  tags   = {
    Name = "Private-nacl"
  }
}

resource "aws_network_acl_association" "public_a" {
  network_acl_id = aws_network_acl.network_acl_public.id
  subnet_id      = aws_subnet.public_subnet_a.id
}

resource "aws_network_acl_association" "public_b" {
  network_acl_id = aws_network_acl.network_acl_public.id
  subnet_id      = aws_subnet.public_subnet_b.id
}

resource "aws_network_acl_association" "private_a" {
  network_acl_id = aws_network_acl.network_acl_private.id
  subnet_id      = aws_subnet.private_subnet_a.id
}

resource "aws_network_acl_association" "private_b" {
  network_acl_id = aws_network_acl.network_acl_private.id
  subnet_id      = aws_subnet.private_subnet_b.id
}


resource "aws_network_acl_rule" "networkAclEntryInPublicAllowAll" {
  network_acl_id = aws_network_acl.network_acl_public.id
  rule_number    = 99
  protocol       = "-1"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"

}


resource "aws_network_acl_rule" "networkAclEntryOutPublicAllowAll" {
  network_acl_id = aws_network_acl.network_acl_public.id
  rule_number    = 99
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
}


resource "aws_network_acl_rule" "networkAclEntryInPrivateAllowAll" {
  network_acl_id = aws_network_acl.network_acl_private.id
  rule_number    = 99
  protocol       = "-1"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "networkAclEntryOutPrivateAllowAll" {
  network_acl_id = aws_network_acl.network_acl_private.id
  rule_number    = 99
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
}
