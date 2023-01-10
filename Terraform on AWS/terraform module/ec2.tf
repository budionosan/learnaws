resource "aws_network_interface" "networkinterface" {
  subnet_id   = aws_subnet.publicsubnet.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "prometheus" {
  ami                    = "ami-0ceecbb0f30a902a6"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.publicsubnet.id
  vpc_security_group_ids = [aws_security_group.securitygroups.id]

  tags = {
    Name = "prometheus"
  }
}