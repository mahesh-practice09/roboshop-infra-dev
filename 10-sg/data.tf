data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.Project}/${var.Env}/vpc"
}