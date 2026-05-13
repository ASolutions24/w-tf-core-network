variable "vnets" {
  type = map(object({
    address_space       = list(string)
    location            = string
    resource_group_name = string
    subnets = map(object({
      address_prefixes = list(string)
      nsg_name         = optional(string)
      route_table_name = optional(string)
    }))
  }))
}