
resource "aws_instance" "web_instance" {
    ami           = var.web_instance_ami     #this is my custom ami id
    instance_type = var.web_server_instance_type
    vpc_security_group_ids      = [aws_security_group.web_instance_sg.id]
    subnet_id                   = aws_subnet.private_subnet_1.id
    key_name                    = "puttykey"
    tags = {
        Name  = "Web-Server"
    }
}
resource "aws_instance" "app_instance" {
    ami           = var.app_instance_ami      #this is my custom ami id
    instance_type = var.app_server_instance_type
    vpc_security_group_ids      = [aws_security_group.app_instance_sg.id]
    subnet_id                   = aws_subnet.private_subnet_2.id
    key_name                    = "puttykey"
    tags = {
        Name  = "app-Server"
    }
}

resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "database-subnet"
  subnet_ids = [aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
}

# Create a database in RDS (Relational Database Service)
resource "aws_db_instance" "database_instance" {
    identifier             = "mydbinstance"
    allocated_storage      = 20
    storage_type           = var.rds_storage_type
    engine                 = var.rds_engine_name
    engine_version         = var.rds_db_engine_version
    instance_class         = var.rds_instance_type
    db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
    username               = var.rds_username
    password               = var.rds_password
    port                   = 3306
    publicly_accessible    = false
    vpc_security_group_ids = [aws_security_group.db_instance_sg.id]
    tags = {
        Name = "terraform-Database"
    }
}


