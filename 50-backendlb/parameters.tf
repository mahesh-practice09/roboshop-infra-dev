resource "aws_ssm_parameter" "alb_listener" {
  name  = "/${var.Project}/${var.environment}/alb_listener_arn"
  type = "String"
  value = aws_lb_listener.http.arn
}