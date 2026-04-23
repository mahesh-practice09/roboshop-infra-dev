resource "aws_ssm_parameter" "frontendalb_listener" {
  name  = "/${var.Project}/${var.environment}/frontendalb_listener_arn"
  type = "String"
  value = aws_lb_listener.https.arn
}