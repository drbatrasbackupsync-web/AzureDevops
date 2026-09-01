variable "key_vaults" {
  description = "Map of Key Vaults to create"
  type = map(object({
    name                       = string
    resource_group_name        = string
    location                   = string
    sku_name                   = optional(string, "standard")
    tenant_id                  = string
    soft_delete_retention_days = optional(number, 7)
    purge_protection_enabled   = optional(bool, false)
    enable_rbac_authorization  = optional(bool, true)
    tags                       = optional(map(string), {})
  }))
}
