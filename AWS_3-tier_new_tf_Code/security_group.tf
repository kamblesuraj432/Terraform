
# Load Balancer-sg
resource "aws_security_group" "load_balancer" {
    name        = "load-balancer-sg"
    vpc_id = aws_vpc.terraformvpc.id
    description = "Security group for the load balancer"
    ingress {
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        cidr_blocks = ["0.0.0.0/0"]
        }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    tags = {
    Name = "load_balancer"
  } 
}

# web-instance-sg
resource "aws_security_group" "web_instance_sg" {
    name        = "web-instance-sg"
    vpc_id = aws_vpc.terraformvpc.id
    description = "Security group for the web-instance"
    ingress {
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        security_groups = [aws_security_group.load_balancer.id]
    }
    # ingress {
    #     protocol    = "tcp"
    #     from_port   = 22
    #     to_port     = 22
    #     cidr_blocks = ["0.0.0.0/0"]
    #     # cidr_blocks = [aws_security_group.load_balancer.id]
    # }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
    Name = "web-instance-sg"
  } 
}

# internal Load Balancer Securitey group
resource "aws_security_group" "internal_load_sg" {
    name        = "internal-load-balancer-sg"
    vpc_id = aws_vpc.terraformvpc.id
    description = "Security group for the internal load balancer"
    ingress {
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        security_groups = [aws_security_group.web_instance_sg.id]
        }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    tags = {
    Name = "internal_load_balancer-sg"
  }
}

resource "aws_security_group" "app_instance_sg" {
    name        = "app-instance-sg"
    vpc_id = aws_vpc.terraformvpc.id
    description = "Security group for the app-instance"
    ingress {
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        security_groups = [aws_security_group.internal_load_sg.id]
    }
    # ingress {
    #     protocol    = "tcp"
    #     from_port   = 9000
    #     to_port     = 9000
    #     security_groups = [aws_security_group.internal_load_sg.id]
    # }
    # ingress {
    #     protocol    = "tcp"
    #     from_port   = 22
    #     to_port     = 22
    #     cidr_blocks = ["0.0.0.0/0"]
    # }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
    Name = "app-instance-sg"
  }
  
}
resource "aws_security_group" "db_instance_sg" {
    name        = "db-instance-sg"
    vpc_id = aws_vpc.terraformvpc.id
    description = "Security group for the web-instance"
    ingress {
        protocol    = "tcp"
        from_port   = 3306
        to_port     = 3306
        security_groups = [aws_security_group.app_instance_sg.id]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
    Name = "db-instance-sg"
   }
  
}