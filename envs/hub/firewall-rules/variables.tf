
# HUB
variable "hub_subscription_id" {}

# FIREWALL
variable "firewall_name" {}
#variable "firewall_pip_name" {}
variable "firewall_rg_name" {}

/*
variable "firewall_policy_id" {
  type = string
}
*/

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


# ROUTING
#variable "route_table_name" {}
#variable "default_route_name" {}

