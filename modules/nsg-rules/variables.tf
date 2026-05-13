/*
variable "nsg_ids" {
  type = map(string)
}

variable "rules" {
  type = map(list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  })))
}
*/

variable "nsgs" {
  description = "NSG definitions"
  type = map(object({
    name                = string
    resource_group_name = string
  }))
}

variable "rules" {
  description = "NSG rules per NSG"
  type = map(list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  })))
}