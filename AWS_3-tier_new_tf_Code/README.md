# Terraform

# Create Resources in VPC AWS
## 1) 1 Vpc
## 2) 2 public-subnets & 4 private-subnets
## 3) 2 route-table - public rt & private rt
## 4) 1 Internet-gatway and attach to public-rt
## 5) 1 Nat-gatway and attach to private-rt

# Create Resources in EC2 AWS
## 1) 1 Internet-facing Load-Balancer (application)
## 2) 2 Internal-facing Load-Balancer (application)
## 3) 2 target group ( internal-load-balancer-tg && internet-load-balancer-tg)
## 4) 5 Surity-groups ( Internet-LB,Internal-LB,Web-Server(ec2),App-Server(ec2),RDS-Instance-sg)
## 5) 1 Internet-facing Load-Balancer
## 6) 1 Internet-facing Load-Balancer


