locals {
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    instance_type = var.instance_type
    cataloguesg_id = data.aws_ssm_parameter.catalogue_sg_id.value
   
    environment = "sbx"
    common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.environment
      }
  
}     