resource "aws_lb" "backendalb" {
  name               = "${var.Project}-${var.environment}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [ local.backend_alb_sg_id ]
  subnets            = [private_subnet_ids]

  enable_deletion_protection = true

  tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-backend-alb"})   
  
  }


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.backendalb.arn
  port              = "80"
  protocol          = "HTTP"
  

   default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> I am from Backend ALB </h1>"
      status_code  = "200"
    }
  }
}