# Configuracion del proovedor AWS
provider "aws" {
  region = "us-east-1" # region donde se desplegaran los recursos

}

# creamos el security group
resource "aws_security_group" "mi-sg" {

  name        = "mi-security-group-terraform"                   # nombre del security group
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

  # regla de salida para HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
# declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
  ami           = "ami-0a93799fb9b1ccbf2" # ID de la imagen de Amazon Linux
  instance_type = "t2.micro"              # tipo de instancia
  key_name      = "mi-primera-llave-mb"   # nombre del par de claves para acceder a la instancia
  tags = {
    Name = "MiInstanciaTerraform2" # etiqueta para identificar la instancia

  }

  vpc_security_group_ids = [aws_security_group.mi-sg.id] # asociamos el security group a la instancia


}
