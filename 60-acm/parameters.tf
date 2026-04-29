resource "aws_ssm_parameter" "roboshop_arn" {
  name  = "/${var.Project}/${var.environment}/roboshop_arn"
  type = "String"
  value = aws_acm_certificate.roboshop.arn
}