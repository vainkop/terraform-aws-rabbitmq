variable "region" {
  description = "region"
  default     = "eu-central-1"
}

variable "env" {
  description = "environment"
}

variable "namespace" {
  description = "RabbitMQ Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  default     = "org"
}

variable "host_instance_type" {
  description = "AWS MQ broker's instance type. e.g. mq.t3.micro for SINGLE_INSTANCE or mq.m5.large for CLUSTER_MULTI_AZ"
  default     = "mq.t3.micro"
}

variable "engine_version" {
  description = "RabbitMQ version of the broker engine"
  type        = string
  default     = "3.10.10"
}

variable "deployment_mode" {
  description = "The deployment mode of RabbiMQ. Supported: SINGLE_INSTANCE and CLUSTER_MULTI_AZ"
  type        = string
  default     = "SINGLE_INSTANCE"
}

variable "application_username" {
  description = "RabbitMQ Application username"
  type        = list(string)
  default     = ["application"]
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = null
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = list(string)
  default     = null
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
  default     = null
}

variable "allowed_security_group_ids" {
  description = "Allowed Security Group IDs"
  type        = list(string)
  default     = null
}
