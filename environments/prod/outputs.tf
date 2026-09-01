output "application_gateway_names" {
  description = "Names of deployed Application Gateways"
  value       = { for k, v in module.application_gateway.application_gateways : k => v.name }
}

output "application_gateway_public_ips" {
  description = "Public IP addresses assigned to Application Gateways"
  value       = { for k, v in module.public_ip.public_ips : k => v.ip_address }
}

output "key_vault_uris" {
  description = "URIs of created Key Vaults"
  value       = { for k, v in module.key_vault.key_vaults : k => v.vault_uri }
}

output "network_interface_ids" {
  description = "IDs of created Network Interfaces"
  value       = { for k, v in module.network_interface.nics : k => v.id }
}
