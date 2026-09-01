resource "azurerm_key_vault" "key_vaults" {
  for_each                   = var.key_vaults
  name                       = each.value.name
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  tenant_id                  = each.value.tenant_id
  sku_name                   = each.value.sku_name
  soft_delete_retention_days = each.value.soft_delete_retention_days
  purge_protection_enabled   = each.value.purge_protection_enabled
  rbac_authorization_enabled = each.value.enable_rbac_authorization
  tags                       = each.value.tags
}
