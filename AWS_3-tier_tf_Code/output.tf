output "vpc_id" {
    value = aws_vpc.terraformvpc 
}
output "aws_internet_gateway_id" {
    value = aws_internet_gateway.terraform_ig.id
}
output "aws_nat_gateway_id" {
    value = aws_nat_gateway.nat_gateway.id
}
output "aws_subnet_1_id" {
    value = aws_subnet.public_subnet_1.id 
}


