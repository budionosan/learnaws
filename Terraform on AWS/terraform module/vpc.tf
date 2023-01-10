resource "aws_vpc" "prometheus" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "prometheusVPC"
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id                  = aws_vpc.prometheus.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "prometheusPublicSubnet"
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id                  = aws_vpc.prometheus.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "prometheusPrivateSubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.prometheus.id

  tags = {
    Name = "prometheusIGW"
  }
}

resource "aws_route_table" "routetablePublic" {
  vpc_id = aws_vpc.prometheus.id
  
  tags = {
    Name = "prometheusRTPublic"
  }
}

resource "aws_route_table" "routetablePrivate" {
  vpc_id = aws_vpc.prometheus.id

  tags = {
    Name = "prometheusRTPrivate"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.routetablePublic.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.routetablePublic.id
  subnet_id      = aws_subnet.publicsubnet.id
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.routetablePrivate.id
  subnet_id      = aws_subnet.privatesubnet.id
}

resource "aws_security_group" "securitygroups" {
  name        = "Allow HTTP, SSH, Prometheus, Alertmanager and NodeExporter"
  description = "Allow HTTP, SSH, Prometheus, Alertmanager and NodeExporter"
  vpc_id      = aws_vpc.prometheus.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "Prometheus"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "Alertmanager"
    from_port        = 9093
    to_port          = 9093
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "NodeExporter"
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP, SSH, Prometheus, Alertmanager and NodeExporter"
  }
}