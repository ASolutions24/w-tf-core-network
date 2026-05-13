variable "location" {
  type = string
}

# HUB
variable "hub_vnet_name" {} #Not required for peering if reading from hub network state file
variable "hub_rg_name" {}   #Not required for peering if reading from hub network state file
variable "hub_subscription_id" {}

# SPOKE
variable "spoke_vnet_name" {}
variable "spoke_vnet_cidr" {}
variable "spoke_rg_name" {}
variable "spoke_subnet_name" {}
variable "spoke_subnet_cidr" {}
variable "spoke_subscription_id" {}

# ROUTING
variable "route_table_name" {}
variable "default_route_name" {}