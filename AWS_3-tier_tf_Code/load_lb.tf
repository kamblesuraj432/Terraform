resource "aws_lb" "my_alb" {
    name               = "my-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.load_balancer.id]
    subnets            = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}
resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.my_alb.id
    port              = "80"
    protocol          = "HTTP"
    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
    }
}
resource "aws_lb_target_group" "target_group" {
    name     = "app-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.terraformvpc.id
    health_check {
    path      = "/"
    interval   = "30"
    timeout    = "5"
    unhealthy_threshold = "2"
    healthy_threshold   = "2"
    }
}

resource "aws_lb_target_group_attachment" "name" {
    target_group_arn = aws_lb_target_group.target_group.arn
    target_id        = aws_instance.web_instance.id 
}