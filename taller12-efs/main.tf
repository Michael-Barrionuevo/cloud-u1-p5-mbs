
# Configuracion del proovedor AWS
provider "aws" {
  region = var.region 
  

}

# creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias" {

  name        = "mi-security-group-terraform-efs-instancias"                   # nombre del security group
  description = "Security group para mi instancia de Terraform" # descripcion del security group
  vpc_id      = "vpc-0b84169fb60e13145"                                              # ID de la VPC donde se creara el security group 
  # reglas de entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
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
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.mi-sg-efs.id]
  }

  # regla de salida para HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

# creamos el security group
resource "aws_security_group" "mi-sg-efs" {

  name        = "mi-security-group-terraform-efs"                   # nombre del security group
  description = "Security group para mi instancia de Terraform" # descripcion del security group
  vpc_id      = "vpc-0b84169fb60e13145"                                              # ID de la VPC donde se creara el security group 
  # reglas de entrada para SSH
  

   ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.mi-sg-efs-instancias.id]
  }

  # regla de salida para HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

# declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_efs" {
  ami           = var.ami_id 
  instance_type = var.tipo_instancia              
  key_name      = var.nombre_llave  
  security_groups = [aws_security_group.mi-sg-efs.name] # asociamos el security group a la instancia
  count = var.cantidad_instancias # cantidad de instancias a crear
  tags = {
    Name = "Mi instancia EFS -${count.index + 1}" # nombre de la instancia
 
  }

  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id] # asociamos el security group a la instancia
  
}

