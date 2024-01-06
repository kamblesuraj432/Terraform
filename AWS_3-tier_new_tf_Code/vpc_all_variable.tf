variable "region" {
    default = "us-east-1"
    type = string
}
variable "access_key" {
    type = string
}

variable "secret_key" {
    type = string
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"
    type = string
}
variable "public_subnet_1_cidr_block" {
    default = "10.0.0.0/20"
    type = string
}
variable "public_subnet_2_cidr_block" {
    default = "10.0.16.0/20"
    type = string  
}
variable "private_subnet_1_cidr_block" {
    default = "10.0.32.0/20"
    type = string
}
variable "private_subnet_2_cidr_block" {
    default = "10.0.48.0/20"
    type = string
}
variable "private_subnet_3_cidr_block" {
    default = "10.0.64.0/20"
    type = string
  
}
variable "private_subnet_4_cidr_block" {
    default = "10.0.80.0/20"
    type = string
  
}