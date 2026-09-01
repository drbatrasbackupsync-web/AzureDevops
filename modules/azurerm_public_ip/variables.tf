variable "public_ips" {
  description = "Map of public IPs to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = optional(string, "Standard")
    tags                = optional(map(string), {})
  }))
}
