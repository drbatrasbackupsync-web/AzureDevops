variable "rgs" {
  type = map(any)
}

variable "vnets" {
  type = map(any)
}

variable "subnets" {
  type = map(any)
}

variable "nsgs" {
  type    = map(any)
  default = {}
}

variable "public_ips" {
  type = map(any)
}

variable "nics" {
  type    = map(any)
  default = {}
}

variable "key_vaults" {
  type    = map(any)
  default = {}
}

variable "storage_accounts" {
  type = map(any)
}

variable "application_gateways" {
  type = map(any)
}
