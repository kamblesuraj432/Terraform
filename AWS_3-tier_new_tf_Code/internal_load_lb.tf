resource "aws_lb" "internal_alb" {
    name               = "my-internal-alb"
    internal           = true
    load_balancer_type = "application"
    security_groups    = [aws_security_group.internal_load_sg.id]
    subnets            = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}
resource "aws_lb_listener" "internal_lb_http" {
    load_balancer_arn = aws_lb.internal_alb.id
    port              = "80"
    protocol          = "HTTP"
    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_lb_target_group.id
    }
}
resource "aws_lb_target_group" "internal_lb_target_group" {
    name     = "internal-lb-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.terraformvpc.id
}

resource "aws_lb_target_group_attachment" "internal_lb_instance_attach" {
    target_group_arn = aws_lb_target_group.internal_lb_target_group.arn
    target_id        = aws_instance.app_instance.id
}