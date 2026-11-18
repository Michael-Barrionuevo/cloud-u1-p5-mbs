#Region donde  se desplegaran los recursos
variable "region" {
    description = "The AWS region"
    type        = string
    default     = "us-east-1"
}

variable "ami_id" {
    description = "ID de la AMI"
    type        = string
    default     = "ami-09bf9dfeeb1e9adbc"

}

variable "tipo_instancia" {
    description = "Tipo de instancia"
    type        = string
    default     = "t2.micro"
}

variable "nombre_llave" {
    description = "Nombre del par de llaves"
    type        = string
    default     = "mi-primera-llave-mb"
}

variable "cantidad_instancias" {
    description = "Cantidad de instancias a crear"
    type        = number
    default     = 2
}