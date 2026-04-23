resource "aws_lb" "frontendalb" {
  name               = "${var.Project}-${var.environment}-frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ local.frontend_alb_sg_id ]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-frontend-alb"})   
  
  }


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.frontendalb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_ssm_parameter.roboshop_arn.value
  

   default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> I am from Frontend ALB </h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "frontendalb" {
  zone_id = var.zone_id
  name    = "*.${var.domain_name}"
  type    = "A"
  alias {
     name = aws_lb.frontendalb.dns_name
     evaluate_target_health = true
  #    zone_id = data.aws_route53_zone.roboshop.zone_id
  # }
  allow_overwrite = true
}

