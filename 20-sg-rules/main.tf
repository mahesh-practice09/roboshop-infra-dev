resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = ["${local.my_ip}/32"]
  security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

resource "aws_security_group_rule" "bastion_mongodb" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

resource "aws_security_group_rule" "catalogue_mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

resource "aws_security_group_rule" "user_mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

resource "aws_security_group_rule" "bastion_redis" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.redis_sg_id.value
}

resource "aws_security_group_rule" "user_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
  security_group_id = data.aws_ssm_parameter.redis_sg_id.value
}

resource "aws_security_group_rule" "cart_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
  security_group_id = data.aws_ssm_parameter.redis_sg_id.value
}

resource "aws_security_group_rule" "bastion_mysql" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.mysql_sg_id.value
}

resource "aws_security_group_rule" "shipping_mysql" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
  security_group_id = data.aws_ssm_parameter.mysql_sg_id.value
}

resource "aws_security_group_rule" "bastion_rabbitmq" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
}

resource "aws_security_group_rule" "payment_rabbitmq" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
  security_group_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
}