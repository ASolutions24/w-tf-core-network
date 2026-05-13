#variable "name" {}
#variable "location" {}
#variable "resource_group_name" {}

/*
variable "network_rules" {
  type = list(object({
    name                  = string
    priority              = number
    action                = string
    source_addresses      = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
    protocols             = list(string)
  }))
  default = []
}
*/

variable "firewall_policy_id" {}
variable "network_rule_collections" {
  type = list(object({
    name     = string
    priority = number
    action   = string

    rules = list(object({
      name                  = string
      source_addresses      = list(string)
      destination_addresses = list(string)
      destination_ports     = list(string)
      protocols             = list(string)
    }))
  }))
}