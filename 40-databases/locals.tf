locals {
    db_private_subnet_ids = split(",", data.aws_ssm_parameter.db_private_subnet_ids.value)
    instance_type = var.instance_type
    mongodbsg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    redissg_id = data.aws_ssm_parameter.redis_sg_id.value
    rabbitmqsg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
    mysqlsg_id = data.aws_ssm_parameter.mysql_sg_id.value
    Env = "sbx"
    common_tags = {
        Project = var.Project
        Terraform = true
        Env = local.Env
      }
    mysql_role_name = join("-", [ for name in ["${var.Project}","${var.Env}","mysql"]: title(name) ])

    mysql_role_policy = join("-", [ for name in ["${var.Project},${var.Env},mysql,policy"]: title(name) ])
}     