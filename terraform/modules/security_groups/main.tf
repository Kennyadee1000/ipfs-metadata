#The Web sg is for public access to login,config,maps, and report builder
resource "aws_security_group" "web_sg" {
  name        = "web"
  description = "Web SG: for internet facing layers e.g maps, login, reports and quicksights"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow tcp access on port 3000"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    ipv6_cidr_blocks = [
      "::/0"
    ]
  }

  ingress {
    description = "Allow TLS for web"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "Self Access on 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name = "WebSG"
  }
}

resource "aws_security_group" "database_sg" {
  name        = "database"
  description = "Database SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Access to database on 3306"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [
      aws_security_group.resource_server_sg.id
    ]
  }

  ingress {
    description     = "Access to database on 5432"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [
      aws_security_group.resource_server_sg.id
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [
      "::/0"
    ]
  }
  tags = {
    Name = "DatabaseSG"
  }
}

resource "aws_security_group" "resource_server_sg" {
  name        = "resource_server_sg"
  description = "SG for OneVision"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow tcp access on port 3000"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [
      aws_security_group.web_sg.id
    ]
  }

  ingress {
    description     = "Allow TLS for web"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [
      aws_security_group.web_sg.id
    ]
  }

  #Self Access on Resource Server
  ingress {
    description = "Self Access on all ports"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    ipv6_cidr_blocks = [
      "::/0"
    ]
  }
  tags = {
    Name = "Resource Server SG"
  }
}
