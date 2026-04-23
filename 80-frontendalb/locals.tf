locals {
    public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
    common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.environment
      }
  
}     