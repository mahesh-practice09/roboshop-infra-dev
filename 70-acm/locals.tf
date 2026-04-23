locals {
    common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.environment
      }
  
}     