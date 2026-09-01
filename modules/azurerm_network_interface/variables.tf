variable "nics" {
  description = "Map of Network Interfaces to create"
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    ip_configuration_name         = string
    subnet_id                     = string
    private_ip_address_allocation = optional(string, "Dynamic")
    private_ip_address            = optional(string)
    tags                          = optional(map(string), {})
  }))
}
