resource "aws_ssm_parameter" "backendalb_listener" {
  name  = "/${var.Project}/${var.environment}/backendalb_listener_arn"
  type = "String"
  value = aws_lb_listener.http.arn
}