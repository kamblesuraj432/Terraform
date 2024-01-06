
provider "aws" {
  region = "us-west-2"  // Replace with your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"  // Replace with desired AZ
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"  // Replace with desired AZ
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2a"  // Replace with desired AZ
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2b"  // Replace with desired AZ
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_nat_gateway.my_nat_gateway.id
  }
}

resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id  // Replace with appropriate private subnet
}

resource "aws_eip" "my_eip" {
  vpc = true
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

###########################################################3


resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for web EC2 instance"
  vpc_id      = aws_vpc.my_vpc.id

  // Define ingress and egress rules as needed for the web EC2 instance
  // Example ingress rule for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Allow from anywhere (for demonstration purposes)
  }
  // Example egress rule allowing all outbound traffic
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_instance" {
  ami                    = "ami-12345678"  // Replace with your desired AMI ID
  instance_type          = "t2.micro"  // Replace with your desired instance type
  subnet_id              = aws_subnet.public_subnet_1.id  // Replace with appropriate public subnet
  vpc_security_group_ids = [ aws_security_group.web_sg.id ]

  // Other instance configurations...
}

resource "aws_lb" "internet_facing_lb" {
  name               = "internet-facing-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  // Other ALB configurations...
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.internet_facing_lb.id
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.web_target_group.id
    type             = "forward"
  }

  // Other listener configurations...
}

resource "aws_lb_target_group" "web_target_group" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  // Other target group configurations...
}

resource "aws_lb_target_group_attachment" "web_attachment" {
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = aws_instance.web_instance.id
  port             = 80
}

resource "aws_lb" "internal_lb" {
  name               = "internal-lb"
  internal           = true
  load_balancer_type = "network"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  // Other NLB configurations...
}

resource "aws_db_instance" "my_db_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
#   name                 = "mydb"
  username             = "admin"
  password             = "mypassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.db_instance_sg.id]
#   subnet_group_name      = "my-db-subnet-group"

  // Other RDS configurations...
}
