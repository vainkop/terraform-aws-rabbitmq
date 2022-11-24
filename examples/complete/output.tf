output "broker_arn" {
  value = module.rabbitmq.broker_arn
}

output "broker_id" {
  value = module.rabbitmq.broker_id
}

output "primary_ssl_endpoint" {
  value       = module.rabbitmq.primary_ssl_endpoint
  description = "AmazonMQ primary SSL endpoint"
}

output "primary_amqp_ssl_endpoint" {
  value = module.rabbitmq.primary_amqp_ssl_endpoint
}

output "primary_stomp_ssl_endpoint" {
  value       = module.rabbitmq.primary_stomp_ssl_endpoint
  description = "AmazonMQ primary STOMP+SSL endpoint"
}

output "primary_mqtt_ssl_endpoint" {
  value       = module.rabbitmq.primary_mqtt_ssl_endpoint
  description = "AmazonMQ primary MQTT+SSL endpoint"
}

output "primary_wss_endpoint" {
  value       = module.rabbitmq.primary_wss_endpoint
  description = "AmazonMQ primary WSS endpoint"
}

output "primary_ip_address" {
  value       = module.rabbitmq.primary_ip_address
  description = "AmazonMQ primary IP address"
}

output "application_username" {
  value = var.application_username
}

output "deployment_mode" {
  value = var.deployment_mode
}
