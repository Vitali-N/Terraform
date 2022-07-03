resource "aws_security_group" "bastion_host"{
  name        = "Bastion_host_SSH"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc-ter
  
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.bastion_host_in_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.bastion_host_eg_cidr_blocks
  }

  tags = {
    Name = "Bastion_host_SSH"
  }
}


resource "aws_security_group" "private_host"{
  name        = "Private_host"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc-ter
  
  ingress {
    description      = "All traffic from your VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.private_host_in_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.private_host_eg_cidr_blocks
  }

  tags = {
    Name = "Private_host_all_traffic"
  }
}
