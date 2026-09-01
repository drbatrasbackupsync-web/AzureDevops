output "application_gateway_names" {
  description = "Names of deployed Application Gateways"
  value       = { for k, v in module.application_gateway.application_gateways : k => v.name }
}

output "application_gateway_public_ips" {
  description = "Public IP addresses assigned to Application Gateways"
  value       = { for k, v in module.public_ip.public_ips : k => v.ip_address }
}
