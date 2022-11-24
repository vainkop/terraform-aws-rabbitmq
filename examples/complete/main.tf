locals {
  subnet_ids = var.deployment_mode == "SINGLE_INSTANCE" ? [var.subnet_ids[0]] : var.subnet_ids
  name       = "${var.env}-rabbitmq"
  tags = {
    Name = local.name
    env  = var.env
  }
}

module "rabbitmq" {
  source              = "vainkop/rabbitmq/aws"
  version             = "0.0.1"
  name                = local.name
  namespace           = var.namespace
  stage               = var.env
  deployment_mode     = var.deployment_mode
  engine_version      = var.engine_version
  host_instance_type  = var.host_instance_type
  mq_application_user = var.application_username

  apply_immediately          = false
  auto_minor_version_upgrade = true
  general_log_enabled        = true

  publicly_accessible        = false
  vpc_id                     = var.vpc_id
  subnet_ids                 = local.subnet_ids
  create_security_group      = true
  allow_all_egress           = false
  allowed_cidr_blocks        = var.vpc_cidr_block
  allowed_security_group_ids = var.allowed_security_group_ids

  tags = local.tags
}
