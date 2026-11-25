
# Configuracion del proovedor AWS
provider "aws" {
  region = var.region 
  

}

# creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias-14" {

  name        = "mi-security-group-terraform-efs-instancias"                   # nombre del security group
  description = "Security group para mi instancia de Terraform" # descripcion del security group
  vpc_id      = "vpc-0b84169fb60e13145"                                              # ID de la VPC donde se creara el security group 


}

# creamos el security group
resource "aws_security_group" "mi-sg-efs-14" {

  name        = "mi-security-group-terraform-efs"                   # nombre del security group
  description = "Security group para mi instancia de Terraform" # descripcion del security group
  vpc_id      = "vpc-0b84169fb60e13145"                                              # ID de la VPC donde se creara el security group 
  
}

# reglas SG Instancias
# Entrada
# entrada SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias-14" {
security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
ip_protocol = "tcp"
from_port = 22
to_port = 22
cidr_ipv4= "0.0.0.0/0"
}

# Salida
# Salida a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs-14" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
  # Destino
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
}

# Salida a Internet all traffic
resource "aws_vpc_security_group_egress_rule" "salida_internet-14" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "-1"
  # Destino
  cidr_ipv4         = "0.0.0.0/0"
}



# Reglas SG EFS
# Entrada
# Regla entrada EFS 2049
resource "aws_vpc_security_group_ingress_rule" "entrada_efs-14" {
  security_group_id = aws_security_group.mi-sg-efs-14.id
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
  #Origen
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
}

# Salida
#  No se requiere reglas de salida


