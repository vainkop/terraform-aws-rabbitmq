variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions"
  default     = false
}

variable "deployment_mode" {
  type        = string
  description = "The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ"
  default     = "SINGLE_INSTANCE"
}

variable "engine_version" {
  type        = string
  description = "The version of the RabbitMQ engine. See https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/broker-engine.html for more details"
  default     = "3.10.10"
}

variable "host_instance_type" {
  type        = string
  description = "The broker's instance type. e.g. mq.t2.micro or mq.m4.large"
  default     = "mq.t3.micro"
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether to enable connections from applications outside of the VPC that hosts the broker's subnets"
  default     = false
}

variable "general_log_enabled" {
  type        = bool
  description = "Enables general logging via CloudWatch"
  default     = true
}

variable "maintenance_day_of_week" {
  type        = string
  description = "The maintenance day of the week. e.g. MONDAY, TUESDAY, or WEDNESDAY"
  default     = "SUNDAY"
}

variable "maintenance_time_of_day" {
  type        = string
  description = "The maintenance time, in 24-hour format. e.g. 02:00"
  default     = "03:00"
}

variable "maintenance_time_zone" {
  type        = string
  description = "The maintenance time zone, in either the Country/City format, or the UTC offset format. e.g. CET"
  default     = "UTC"
}

variable "mq_application_user" {
  type        = list(string)
  description = "Application username"
  default     = []
}

variable "mq_application_password" {
  type        = list(string)
  description = "Application password"
  default     = []
  sensitive   = true
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to create the broker in"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of VPC subnet IDs"
}

variable "overwrite_ssm_parameter" {
  type        = bool
  description = "Whether to overwrite an existing SSM parameter"
  default     = true
}

variable "ssm_parameter_name_format" {
  type        = string
  description = "SSM parameter name format"
  default     = "/%s/%s"
}

variable "ssm_path" {
  type        = string
  description = "The first parameter to substitute in `ssm_parameter_name_format`"
  default     = "mq"
}

variable "mq_application_user_ssm_parameter_name" {
  type        = string
  description = "SSM parameter name for Application username"
  default     = "mq_application_username"
}

variable "mq_application_password_ssm_parameter_name" {
  type        = string
  description = "SSM parameter name for Application password"
  default     = "mq_application_password"
}

variable "kms_ssm_key_arn" {
  type        = string
  description = "ARN of the AWS KMS key used for SSM encryption"
  default     = "alias/aws/ssm"
}

variable "allowed_ingress_ports" {
  type        = list(number)
  description = <<-EOT
    List of TCP ports to allow access to in the created security group.
    Default is to allow access to all ports. Set `create_security_group` to `false` to disable.
    Note: List of ports must be known at "plan" time.
    EOT
  default     = []
}

# Security Group

variable "create_security_group" {
  type        = bool
  default     = true
  description = "Set `true` to create and configure a new security group. If false, `associated_security_group_ids` must be provided."
}

variable "associated_security_group_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.
    These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access.
    EOT
}

variable "allowed_security_group_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    A list of IDs of Security Groups to allow access to the security group created by this module.
    The length of this list must be known at "plan" time.
    EOT
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = <<-EOT
    A list of IPv4 CIDRs to allow access to the security group created by this module.
    The length of this list must be known at "plan" time.
    EOT
}

variable "allowed_ipv6_cidr_blocks" {
  type        = list(string)
  default     = []
  description = <<-EOT
    A list of IPv6 CIDRs to allow access to the security group created by this module.
    The length of this list must be known at "plan" time.
    EOT
}

variable "allowed_ipv6_prefix_list_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    A list of IPv6 Prefix Lists IDs to allow access to the security group created by this module.
    The length of this list must be known at "plan" time.
    EOT
}

variable "security_group_name" {
  type        = list(string)
  default     = []
  description = <<-EOT
    The name to assign to the created security group. Must be unique within the VPC.
    If not provided, will be derived from the `null-label.context` passed in.
    If `create_before_destroy` is true, will be used as a name prefix.
    EOT
}

variable "security_group_description" {
  type        = string
  default     = "Managed by Terraform"
  description = <<-EOT
    The description to assign to the created Security Group.
    Warning: Changing the description causes the security group to be replaced.
    EOT
}

variable "security_group_create_before_destroy" {
  type        = bool
  default     = true
  description = <<-EOT
    Set `true` to enable Terraform `create_before_destroy` behavior on the created security group.
    We only recommend setting this `false` if you are upgrading this module and need to keep
    the existing security group from being replaced.
    Note that changing this value will always cause the security group to be replaced.
    EOT
}

variable "security_group_create_timeout" {
  type        = string
  default     = "10m"
  description = "How long to wait for the security group to be created."
}

variable "security_group_delete_timeout" {
  type        = string
  default     = "15m"
  description = <<-EOT
    How long to retry on `DependencyViolation` errors during security group deletion from
    lingering ENIs left by certain AWS services such as Elastic Load Balancing.
    EOT
}

variable "allow_all_egress" {
  type        = bool
  default     = true
  description = <<-EOT
    If `true`, the created security group will allow egress on all ports and protocols to all IP addresses.
    If this is false and no egress rules are otherwise specified, then no egress will be allowed.
    EOT
}

variable "additional_security_group_rules" {
  type        = list(any)
  default     = []
  description = <<-EOT
    A list of Security Group rule objects to add to the created security group, in addition to the ones
    this module normally creates. (To suppress the module's rules, set `create_security_group` to false
    and supply your own security group(s) via `associated_security_group_ids`.)
    The keys and values of the objects are fully compatible with the `aws_security_group_rule` resource, except
    for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique and known at "plan" time.
    For more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
    and https://github.com/vainkop/terraform-aws-security-group.
    EOT
}
