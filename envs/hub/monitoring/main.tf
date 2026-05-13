module "monitoring" {
  source = "../../../modules/monitoring-core"

  providers = {
    azurerm = azurerm.hub
  }

  workspace_name     = var.workspace_name
  action_group_name  = var.action_group_name

  location            = var.location
  resource_group_name = var.resource_group_name

  alert_email = "cloudops@company.com"

  #tags = var.tags
}

data "azurerm_virtual_network" hub_vnet {
  provider = azurerm.hub
  name                = var.hub_vnet_name
  resource_group_name = var.hub_rg_name
}

module "hub_vnet_diagnostics" {
  source = "../../../modules/diagnostic-settings"

  providers = {
    azurerm = azurerm.hub
  }

  name = var.hub_vnet_diagnostics_name

  target_resource_id = data.azurerm_virtual_network.hub_vnet.id
  log_analytics_workspace_id = module.monitoring.workspace_id

  metrics = ["AllMetrics"]
}
