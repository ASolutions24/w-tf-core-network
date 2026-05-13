#Use this if reading hub vnet resource from real environment
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
  #source = "../../../modules/network-core"

  providers = {
    azurerm = azurerm.spoke
  }

  vnet_name           = var.spoke_vnet_name
  address_space       = [var.spoke_vnet_cidr]
  resource_group_name = var.spoke_rg_name
  location            = var.location

  subnets = var.spoke_subnets
}

module "security" {
  providers = {
    azurerm = azurerm.spoke
  }
  source  = "../../modules/network-security"
  #subnets = module.hub_core.subnets
  subnets = {
    for k, v in module.spoke_core.subnets :
    k => v
    if v.subnet_name != "AzureFirewallSubnet"
  }
}

module "routing" {
  providers = {
    azurerm = azurerm.spoke
  }
  source  = "../../modules/network-routing"
  #subnets = module.hub_core.subnets
  subnets = {
    for k, v in module.spoke_core.subnets :
    k => v
    if v.subnet_name != "AzureFirewallSubnet"
  }
}

module "association" {
  source = "../../modules/network-association"

  subnet_ids = module.spoke_core.subnet_ids
  nsg_ids         = module.security.nsg_ids
  route_table_ids = module.routing.route_table_ids
}

module "peering" {
  source = "../../modules/vnet-peering"

  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.spoke
  }

  spoke_rg        = var.spoke_rg_name
  spoke_vnet_name = var.spoke_vnet_name
  spoke_vnet_id = module.spoke_core.vnet_id

  hub_rg        = var.hub_rg_name #Use this if using api to read real hub vnet resource
  hub_vnet_name = var.hub_vnet_name #Use this if using api to read real hub vnet resource
  hub_vnet_id   = data.azurerm_virtual_network.hub.id #Use this if using api to read real hub vnet resource

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
        #next_hop_ip    = module.firewall.firewall_private_ip
      }
    ]
    if v.subnet_name != "AzureFirewallSubnet"
  }
}

resource "random_id" "suffix" {
  byte_length = 2
}
locals {
  storage_account_name = "${var.storage_account_prefix}${random_id.suffix.hex}"
}

module "storage" {
  source = "../../modules/storage-account"

  providers = {
    azurerm = azurerm.spoke
  }

  name                = local.storage_account_name
  resource_group_name = var.spoke_rg_name
  location            = var.location
}

data "azurerm_private_dns_zone" "this" {
  provider = azurerm.hub

  for_each = local.private_dns_zone_names

  name                = each.value
  resource_group_name = var.hub_rg_name
}

locals {
  resource_ids = {
    storage = module.storage.id
  }
  private_dns_zone_names = {
    blob = "privatelink.blob.core.windows.net"
    file = "privatelink.file.core.windows.net"
  }
}

module "storage_pe" {
  source = "../../modules/private-endpoint"

  providers = {
    azurerm = azurerm.spoke
  }

  for_each = var.private_endpoint_config

  name                = "pe-${each.key}"
  location            = var.location
  resource_group_name = var.spoke_rg_name

  subnet_id = module.spoke_core.subnet_ids[
    each.value.subnet_name
  ]

  #private_connection_resource_id = each.value.resource_id
  private_connection_resource_id = local.resource_ids[
      each.value.target_resource_key
    ]

  subresource_names = each.value.subresource_names

  private_dns_zone_ids = [
    data.azurerm_private_dns_zone.this[
      each.value.dns_zone_key
    ].id
  ]
}

data "azurerm_log_analytics_workspace" la_hub {
  provider            = azurerm.hub
  name                = var.hub_workspace_name
  resource_group_name = var.hub_workspace_rg
}

module "storage_diagnostics" {
  source = "../../modules/diagnostic-settings"

  providers = {
    azurerm = azurerm.spoke
  }

  name = "diag-storage"

  target_resource_id = module.storage.id

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.la_hub.id

  logs = [
    "StorageRead",
    "StorageWrite",
    "StorageDelete"
  ]
}

module "dev_vnet_diagnostics" {
  source = "../../modules/diagnostic-settings"

  providers = {
    azurerm = azurerm.spoke
  }

  name = var.dev_vnet_diagnostics_name

  target_resource_id = module.spoke_core.vnet_id

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.la_hub.id

  metrics = ["AllMetrics"]
}