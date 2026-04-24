locals {
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
    common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.environment
      }
  
}     