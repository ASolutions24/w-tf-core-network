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
#variable "spoke_subnet_cidr" {}
#variable "spoke_subnet_name" {}
variable "spoke_subnets" {
  description = "Map of hub subnets"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "spoke_subscription_id" {}

# Storage
variable "storage_account_prefix" {
  type = string
}

variable "pe_sub_resource" {}

variable "private_endpoint_config" {
  description = "Map of private endpoint configurations"

  type = map(object({
    target_resource_key = string
    subnet_name         = string
    subresource_names   = list(string)
    dns_zone_key        = string

    # Optional overrides
    #location            = optional(string)
    #resource_group_name = optional(string)

    # Future flexibility
    #manual_connection   = optional(bool, false)
    #request_message     = optional(string)

    #tags                = optional(map(string), {})
  }))
}

variable "hub_workspace_name" {}
variable "hub_workspace_rg" {}
variable "dev_vnet_diagnostics_name" {}