locals {

  create_security_group         = local.enabled && var.create_security_group
  additional_security_group_ids = sort(compact(var.associated_security_group_ids))

  allowed_security_group_ids   = var.allowed_security_group_ids
  allowed_cidr_blocks          = var.allowed_cidr_blocks
  allowed_ipv6_cidr_blocks     = var.allowed_ipv6_cidr_blocks
  allowed_ipv6_prefix_list_ids = var.allowed_ipv6_prefix_list_ids

  allowed_ingress_ports = var.allowed_ingress_ports

  sg_allowed_rule_enabled = local.create_security_group && (
    length(local.allowed_security_group_ids) > 0 ||
    length(local.allowed_cidr_blocks) > 0 ||
    length(local.allowed_ipv6_cidr_blocks) > 0 ||
    length(local.allowed_ipv6_prefix_list_ids) > 0
  )

  sg_allow_all_ports = [
    {
      key         = "_all_ingress"
      type        = "ingress"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Allow all ports"
    }
  ]

  sg_allow_specific_ports = [
    for port in local.allowed_ingress_ports : {
      key         = tostring(port)
      type        = "ingress"
      from_port   = port
      to_port     = port
      protocol    = "tcp"
      description = "Allow port ${port}"
    }
  ]

  sg_rule_matrix = local.sg_allowed_rule_enabled ? [{
    key                       = "_allowed_ingress"
    source_security_group_ids = local.allowed_security_group_ids
    cidr_blocks               = local.allowed_cidr_blocks
    ipv6_cidr_blocks          = local.allowed_ipv6_cidr_blocks
    prefix_list_ids           = local.allowed_ipv6_prefix_list_ids
    rules                     = length(local.sg_allow_specific_ports) == 0 ? local.sg_allow_all_ports : local.sg_allow_specific_ports
  }] : []
}

module "security_group" {
  source  = "vainkop/security-group/aws"
  version = "0.0.1"

  enabled                       = local.create_security_group
  security_group_name           = var.security_group_name
  create_before_destroy         = var.security_group_create_before_destroy
  security_group_create_timeout = var.security_group_create_timeout
  security_group_delete_timeout = var.security_group_delete_timeout

  security_group_description = var.security_group_description
  allow_all_egress           = var.allow_all_egress
  rules                      = var.additional_security_group_rules
  rule_matrix                = local.sg_rule_matrix
  vpc_id                     = var.vpc_id

  context = module.this.context
}
