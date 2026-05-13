variable "location" {
  type = string
}

# HUB
variable "hub_vnet_name" {}
variable "hub_vnet_cidr" {}
variable "hub_rg_name" {}
#variable "hub_firewall_subnet_cidr" {}
variable "hub_subnets" {
  description = "Map of hub subnets"
  type = map(object({
    address_prefixes = list(string)
  }))
}
variable "hub_subscription_id" {}


# FIREWALL
variable "firewall_name" {}
variable "firewall_pip_name" {}

# Private DNS Zones
variable "private_dns_zones" {
  type = map(object({
    name = string
  }))
}

# Private DNS Resolver 
variable "dns_forwarding_rules" {
  type = list(object({
    name        = string
    domain_name = string
    target_dns_servers = list(object({
      ip   = string
      port = number
    }))
  }))
}