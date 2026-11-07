# Buscamos de forma dinámica la AMI de Windows Server 2022
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

# Security Group para Windows
resource "aws_security_group" "mi-sg-windows" {
  name        = "mi-security-group-windows-terraform"
  description = "Security group para instancia Windows en Terraform"
  vpc_id      = "vpc-0b84169fb60e13145"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_windows" {
  ami           = data.aws_ami.windows.id
  instance_type = "t3.medium" 
  key_name      = "mi-primera-llave-mb"

  tags = {
    Name = "MiInstanciaWindowsTerraform"
  }

  vpc_security_group_ids = [aws_security_group.mi-sg-windows.id]
}