locals {
      common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.environment
    }

    tags = merge(local.common_tags, 
    { Name = "${var.Project}-${var.environment}-Bastion"} )
     
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value) 
  bastionsg_id = data.aws_ssm_parameter.bastion_sg_id.value
}     