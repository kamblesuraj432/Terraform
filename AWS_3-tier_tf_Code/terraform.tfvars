# Provider Block
region = "us-east-1"
access_key = "lkajlkjaljalkdjlkjalkjalk"
secret_key = "lkajhtnaieuqoipajd nalldasklj ladndsjkljl"

# Vpc block
vpc_cidr = "172.15.0.0/16"
public_subnet_1_cidr_block = "172.15.0.0/20"
public_subnet_2_cidr_block = "172.15.16.0/20"
private_subnet_1_cidr_block = "172.15.32.0/20"
private_subnet_2_cidr_block = "172.15.48.0/20"
private_subnet_3_cidr_block = "172.15.64.0/20"
private_subnet_4_cidr_block = "172.15.80.0/20"

# web-instance block
web_instance_ami = ""  # please insert here your custom ami_id
web_server_instance_type = ""

# app-instance block
app_instance_ami = ""  # please insert here your custom ami_id
app_server_instance_type = ""

# RDS-instance block
rds_engine_name = "mysql"
rds_db_engine_version = "8.0.35"
rds_storage_type = ""
rds_instance_type = "db.t2.micro"
rds_username = ""
rds_password = ""
