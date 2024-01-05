
resource "aws_vpc" "terraformvpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "terraform_vpc"
    }
}

data "aws_availability_zones" "available" {
    state = "available"
  
}
resource "aws_subnet" "public_subnet_1" {
    vpc_id     = aws_vpc.terraformvpc.id
    cidr_block = var.public_subnet_1_cidr_block
    availability_zone   = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet-1"
        }
}
resource "aws_subnet" "public_subnet_2" {
    vpc_id     = aws_vpc.terraformvpc.id
    cidr_block = var.public_subnet_2_cidr_block
    availability_zone   = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet-2"
        }
}
resource "aws_subnet" "private_subnet_1" {
    vpc_id     = aws_vpc.terraformvpc.id
    cidr_block = var.private_subnet_1_cidr_block
    availability_zone   = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "private-Subnet-1"
        }
}
resource "aws_subnet" "private_subnet_2" {
    vpc_id     = aws_vpc.terraformvpc.id
    cidr_block = var.private_subnet_2_cidr_block
    availability_zone   = data.aws_availability_zones.available.names[1]
    tags = {
        Name = "private-Subnet-2"
        }
}
resource "aws_subnet" "private_subnet_3" {
    vpc_id     = aws_vpc.terraformvpc.id
    cidr_block = var.private_subnet_3_cidr_block
    availability_zone   = data.aws_availability_zones.available.names[2]
    tags = {
        Name = "private-Subnet-3"
        }
}
resource "aws_subnet" "private_subnet_4" {
    vpc_id     = aws_vpc.terraformvpc.id
    cidr_block = var.private_subnet_4_cidr_block
    availability_zone   = data.aws_availability_zones.available.names[3]
    tags = {
        Name = "private-Subnet-4"
        }
}

resource "aws_internet_gateway" "terraform_ig" {
    vpc_id = aws_vpc.terraformvpc.id
    tags = {
        Name = "TerraformIG"
        }
}

resource "aws_eip" "nat_gateway_eip" {
    vpc = true
    tags = {
        Name = "NATGatewayEIP"
    }
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_gateway_eip.id
    subnet_id     = aws_subnet.public_subnet_1.id
    tags = {
        Name = "NATGateway"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.terraformvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform_ig.id
        }
        tags = {
            Name = "PublicRouteTable"
            }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.terraformvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
        }
        tags = {
            Name = "PrivateRouteTable"
            }
}

resource "aws_route_table_association" "public_route_association_1" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public_subnet_1.id
}
resource "aws_route_table_association" "public_route_association_2" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "private_route_association_1" {
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private_route_association_2" {
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = aws_subnet.private_subnet_2.id
}
resource "aws_route_table_association" "private_route_association_3" {
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = aws_subnet.private_subnet_3.id
}
resource "aws_route_table_association" "private_route_association_4" {
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = aws_subnet.private_subnet_4.id
}

