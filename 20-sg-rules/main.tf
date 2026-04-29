# Bastion
resource "aws_security_group_rule" "internet_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = ["0.0.0.0/0"]
  cidr_blocks = ["${local.my_ip}/32"]
  # which SG you are creating this rule
  security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
}

# MongoDB
resource "aws_security_group_rule" "bastion_mongodb" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

resource "aws_security_group_rule" "catalogue_mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

resource "aws_security_group_rule" "user_mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
  security_group_id = data.aws_ssm_parameter.mongodb_sg_id.value
}

# Redis
resource "aws_security_group_rule" "bastion_redis" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.redis_sg_id.value
}

resource "aws_security_group_rule" "user_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
  security_group_id =  data.aws_ssm_parameter.redis_sg_id.value
}

resource "aws_security_group_rule" "cart_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
  security_group_id = data.aws_ssm_parameter.redis_sg_id.value
}

# MySQL
resource "aws_security_group_rule" "bastion_mysql" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.mysql_sg_id.value
}

resource "aws_security_group_rule" "shipping_mysql" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
  security_group_id = data.aws_ssm_parameter.mysql_sg_id.value
}

# RabbitMQ
resource "aws_security_group_rule" "bastion_rabbitmq" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
}

resource "aws_security_group_rule" "payment_rabbitmq" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
  security_group_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
}

# Catalogue
resource "aws_security_group_rule" "bastion_catalogue" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
}

resource "aws_security_group_rule" "backendalb_catalogue" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
  security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
}

# User
resource "aws_security_group_rule" "bastion_user" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.user_sg_id.value
}

resource "aws_security_group_rule" "backendalb_user" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
  security_group_id = data.aws_ssm_parameter.user_sg_id.value
}

# Cart
resource "aws_security_group_rule" "bastion_cart" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.cart_sg_id.value
}

resource "aws_security_group_rule" "backendalb_cart" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
  security_group_id = data.aws_ssm_parameter.cart_sg_id.value
}

# Shipping
resource "aws_security_group_rule" "bastion_shipping" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
}

resource "aws_security_group_rule" "backendalb_shipping" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id =data.aws_ssm_parameter.backend_alb_sg_id.value
  security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
}

# Payment
resource "aws_security_group_rule" "bastion_payment" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.payment_sg_id.value
}

resource "aws_security_group_rule" "backedalb_payment" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
  security_group_id = data.aws_ssm_parameter.payment_sg_id.value
}

# Backend ALB
resource "aws_security_group_rule" "bastion_backendalb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}

resource "aws_security_group_rule" "catalogue_backendalb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
  security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}

resource "aws_security_group_rule" "user_backendalb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
  security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}

resource "aws_security_group_rule" "cart_backendalb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
  security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}

resource "aws_security_group_rule" "shipping_backendalb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
  security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}

resource "aws_security_group_rule" "payment_backendalb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
  security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}

resource "aws_security_group_rule" "frontend_backendalb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.frontend_sg_id.value
  security_group_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}

# Frontend
resource "aws_security_group_rule" "bastion_frontend" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  security_group_id = data.aws_ssm_parameter.frontend_sg_id.value
}

resource "aws_security_group_rule" "frontendalb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
  security_group_id = data.aws_ssm_parameter.frontend_sg_id.value
}

# Frontend ALB
resource "aws_security_group_rule" "public_frontendalb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
}

#openvpn

resource "aws_security_group_rule" "internet_openvpn" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.openvpn_sg_id.value
}

resource "aws_security_group_rule" "public_frontendalb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
}

resource "aws_security_group_rule" "public_frontendalb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
}