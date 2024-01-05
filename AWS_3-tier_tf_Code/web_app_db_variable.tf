# web-instance variable
variable "web_instance_ami" {
    description = "The AMI to use for the web server instance."
    type = string
}
variable "web_server_instance_type" {
    default = "t2.micro"
    type = string
}

# app-instance variable
variable "app_instance_ami" {
    description = "The AMI to use for the app server instance."
    type = string
}
variable "app_server_instance_type" {
    default = "t2.micro"
    type = string
}

# RDS-instance variable
variable "rds_engine_name" {
    description = "Engine name of database running in RDS, e.g., mysql or post"
    default     = "mysql"
    type        = string
}
variable "rds_db_engine_version" {
    description = "Database engine version to install on RDS instances."
    default     = "8.0.35" # Mysql version
    type = string
}
variable "rds_storage_type" {
    description = "Storage type for the RDS DB instance. Valid values are standard, gp"
    default = "gp2"
    type = string
}
variable "rds_instance_type" {
    default = "db.t2.micro"
    type = string
}
variable "rds_username" {
    default = "root"
    type = string
}
variable "rds_password" {
    default = "suraj1234"
    type = string
}


