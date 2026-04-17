locals {
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
    common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.environment
      }
    mysql_role_name = join("-", [ for name in ["${var.Project}","${var.environment}","mysql"]: title(name) ])

    mysql_role_policy = join("-", [ for name in ["${var.Project}","${var.environment}","mysqlpolicy"]: title(name) ])
}     