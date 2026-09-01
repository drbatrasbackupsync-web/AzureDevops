output "public_ips" {
  description = "Map of created public IPs"
  value       = azurerm_public_ip.public_ips
}
