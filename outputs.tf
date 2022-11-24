output "broker_id" {
  value       = join("", aws_mq_broker.default.*.id)
  description = "RabbitMQ broker ID"
}

output "broker_arn" {
  value       = join("", aws_mq_broker.default.*.arn)
  description = "RabbitMQ broker ARN"
}

output "primary_console_url" {
  value       = try(aws_mq_broker.default[0].instances[0].console_url, "")
  description = "RabbitMQ active web console URL"
}

output "primary_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[0].endpoints[0], "")
  description = "RabbitMQ primary SSL endpoint"
}

output "primary_amqp_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[0].endpoints[1], "")
  description = "RabbitMQ primary AMQP+SSL endpoint"
}

output "primary_stomp_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[0].endpoints[2], "")
  description = "RabbitMQ primary STOMP+SSL endpoint"
}

output "primary_mqtt_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[0].endpoints[3], "")
  description = "RabbitMQ primary MQTT+SSL endpoint"
}

output "primary_wss_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[0].endpoints[4], "")
  description = "RabbitMQ primary WSS endpoint"
}

output "primary_ip_address" {
  value       = try(aws_mq_broker.default[0].instances[0].ip_address, "")
  description = "RabbitMQ primary IP address"
}

output "secondary_console_url" {
  value       = try(aws_mq_broker.default[0].instances[1].console_url, "")
  description = "RabbitMQ secondary web console URL"
}

output "secondary_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[1].endpoints[0], "")
  description = "RabbitMQ secondary SSL endpoint"
}

output "secondary_amqp_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[1].endpoints[1], "")
  description = "RabbitMQ secondary AMQP+SSL endpoint"
}

output "secondary_stomp_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[1].endpoints[2], "")
  description = "RabbitMQ secondary STOMP+SSL endpoint"
}

output "secondary_mqtt_ssl_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[1].endpoints[3], "")
  description = "RabbitMQ secondary MQTT+SSL endpoint"
}

output "secondary_wss_endpoint" {
  value       = try(aws_mq_broker.default[0].instances[1].endpoints[4], "")
  description = "RabbitMQ secondary WSS endpoint"
}

output "secondary_ip_address" {
  value       = try(aws_mq_broker.default[0].instances[1].ip_address, "")
  description = "RabbitMQ secondary IP address"
}

output "application_username" {
  value       = local.mq_application_user
  description = "RabbitMQ application username"
}

output "security_group_id" {
  value       = module.security_group.id
  description = "The ID of the created security group"
}

output "security_group_arn" {
  value       = module.security_group.arn
  description = "The ARN of the created security group"
}

output "security_group_name" {
  value       = module.security_group.name
  description = "The name of the created security group"
}
