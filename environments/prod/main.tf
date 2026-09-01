data "azurerm_client_config" "current" {}

module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.vnets
}

module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../../modules/azurerm_subnet"
  subnets    = var.subnets
}

module "network_security_group" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "network_interface" {
  depends_on = [module.subnet]
  source     = "../../modules/azurerm_network_interface"
  nics = {
    for k, v in var.nics : k => merge(v, {
      subnet_id = module.subnet.subnets[v.subnet_key].id
    })
  }
}

module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_key_vault"
  key_vaults = {
    for k, v in var.key_vaults : k => merge(v, {
      tenant_id = data.azurerm_client_config.current.tenant_id
    })
  }
}

module "storage_account" {
  depends_on       = [module.resource_group]
  source           = "../../modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}

module "application_gateway" {
  depends_on = [module.subnet, module.public_ip]
  source     = "../../modules/azurerm_application_gateway"
  application_gateways = {
    for k, v in var.application_gateways : k => {
      name                = v.name
      resource_group_name = v.resource_group_name
      location            = v.location
      tags                = try(v.tags, {})
      sku                 = v.sku
      gateway_ip_configuration = {
        name      = v.gateway_ip_configuration.name
        subnet_id = module.subnet.subnets[v.gateway_ip_configuration.subnet_key].id
      }
      frontend_ports = v.frontend_ports
      frontend_ip_configurations = [
        for fip in v.frontend_ip_configurations : {
          name                 = fip.name
          public_ip_address_id = module.public_ip.public_ips[fip.public_ip_key].id
        }
      ]
      backend_address_pools = v.backend_address_pools
      backend_http_settings = v.backend_http_settings
      http_listeners        = v.http_listeners
      request_routing_rules = v.request_routing_rules
    }
  }
}
