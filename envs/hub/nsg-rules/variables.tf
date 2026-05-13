variable "nsgs" {
  description = "Map of NSGs where rules will be applied"
  type = map(object({
    name                = string
    resource_group_name = string
  }))
}
variable "rules" {
  description = "Map of NSG rules grouped by NSG key"
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

variable "hub_subscription_id" {}