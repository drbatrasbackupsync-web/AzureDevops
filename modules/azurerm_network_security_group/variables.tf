variable "nsgs" {
  description = "Map of Network Security Groups and security rules to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })), [])
    tags = optional(map(string), {})
  }))
}
