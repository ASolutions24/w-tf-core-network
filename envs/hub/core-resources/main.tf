
module "hub_core" {
  #source = "../../modules/network-core"
  source = "../../../modules/network-core"

  providers = {
    azurerm = azurerm.hub
  }

  vnet_name           = var.hub_vnet_name
  address_space       = [var.hub_vnet_cidr]
  resource_group_name = var.hub_rg_name
  location            = var.location
  /*
  subnets = {
    AzureFirewallSubnet = {
      address_prefixes = [var.hub_firewall_subnet_cidr]
    }
  }
  */
  subnets = var.hub_subnets
}

module "security" {
  providers = {
    azurerm = azurerm.hub
  }
  source  = "../../../modules/network-security"
  #subnets = module.hub_core.subnets
  subnets = {
    for k, v in module.hub_core.subnets :
    k => v
    if v.subnet_name != "AzureFirewallSubnet"
  }
}

module "routing" {
  providers = {
    azurerm = azurerm.hub
  }
  source  = "../../../modules/network-routing"
  #subnets = module.hub_core.subnets
  subnets = {
    for k, v in module.hub_core.subnets :
    k => v
    if v.subnet_name != "AzureFirewallSubnet"
  }
}

module "association" {
  source = "../../../modules/network-association"
  providers = {
    azurerm = azurerm.hub
  }

  subnet_ids = module.hub_core.subnet_ids
  nsg_ids         = module.security.nsg_ids
  route_table_ids = module.routing.route_table_ids
}

module "routes" {
  source = "../../../modules/route-definitions"
  providers = {
    azurerm = azurerm.hub
  }
  route_table_ids = module.routing.route_table_ids

  routes = {
    for k, v in module.hub_core.subnets :
    k => [
      {
        name           = "default-to-firewall"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_ip    = "10.100.1.4"
      }
    ]
    if v.subnet_name != "AzureFirewallSubnet"
  }
}
/*
module "firewall" {
  source = "../../../modules/firewall"

  providers = {
    azurerm = azurerm.hub
  }

  name                = "azfw-hub"
  location            = "Australia East"
  resource_group_name = "rg-network-hub"

  subnet_id = module.hub_core.subnet_ids["AzureFirewallSubnet"]
}
*/
module "private_dns" {
  source = "../../../modules/private-dns-zones"

  providers = {
    azurerm = azurerm.hub
  }

  resource_group_name = var.hub_rg_name
  location            = var.location
  vnet_id             = module.hub_core.vnet_id

  zones = var.private_dns_zones
}
/*
module "dns_resolver" {
  source = "../../../modules/dns-resolver"

  providers = {
    azurerm = azurerm.hub
  }

  name                = "dns-resolver-hub"
  location            = var.location
  resource_group_name = var.hub_rg_name

  vnet_id            = module.hub_core.vnet_id
  inbound_subnet_id  = module.hub_core.subnet_ids["dns-inbound"]
  outbound_subnet_id = module.hub_core.subnet_ids["dns-outbound"]
}

module "dns_ruleset" {
  source = "../../../modules/dns-forwarding-ruleset"

  providers = {
    azurerm = azurerm.hub
  }

  name                = "dns-ruleset-hub"
  location            = var.location
  resource_group_name = var.hub_rg_name

  outbound_endpoint_id = module.dns_resolver.outbound_endpoint_id
  vnet_id              = module.hub_core.vnet_id

  rules = var.dns_forwarding_rules
}
*/