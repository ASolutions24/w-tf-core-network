data "azurerm_virtual_network" "hub" {
  provider            = azurerm.hub
  name                = var.hub_vnet_name
  resource_group_name = var.hub_rg_name
}

/*
#Use this data read method if readying from hub vnet statefile only.
data "terraform_remote_state" "hub" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tf-prod-sf"          # your state RG
    storage_account_name = "stgtfprodstatefile"            # your storage account
    container_name       = "tfstate"
    key                  = "network-hub.tfstate"
  }
}
*/

module "spoke_core" {
  source = "../../modules/network-core"

  providers = {
    azurerm = azurerm.spoke
  }

  vnet_name           = var.spoke_vnet_name
  address_space       = [var.spoke_vnet_cidr]
  resource_group_name = var.spoke_rg_name
  location            = var.location

  subnets = {
    (var.spoke_subnet_name) = {
      address_prefixes = [var.spoke_subnet_cidr]
    }
  }
}

module "security" {
  source  = "../../modules/network-security"
  subnets = module.spoke_core.subnets
}

module "routing" {
  source  = "../../modules/network-routing"
  subnets = module.spoke_core.subnets
}

module "association" {
  source = "../../modules/network-association"

  subnet_ids      = module.spoke_core.subnet_ids
  nsg_ids         = module.security.nsg_ids
  route_table_ids = module.routing.route_table_ids
}

module "peering" {
  source = "../../modules/vnet-peering"

  /*
  providers = {
    azurerm       = azurerm
    azurerm.hub   = azurerm.hub
  }
  */
  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.spoke
  }

  spoke_rg        = var.spoke_rg_name
  spoke_vnet_name = var.spoke_vnet_name
  spoke_vnet_id   = module.spoke_core.vnet_id

  hub_rg        = var.hub_rg_name
  hub_vnet_name = var.hub_vnet_name
  hub_vnet_id   = data.azurerm_virtual_network.hub.id

  /*
  #Use this if reading hub vnet from statefile
  hub_rg   = data.terraform_remote_state.hub.outputs.resource_group_name
  hub_vnet_name = data.terraform_remote_state.hub.outputs.vnet_name
  hub_vnet_id = data.terraform_remote_state.hub.outputs.vnet_id
  */
}

module "routes" {
  source = "../../modules/route-definitions"

  route_table_ids = module.routing.route_table_ids

  routes = {
    for k, v in module.spoke_core.subnets :
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