data "azurerm_firewall" "fw" {
  #provider            = azurerm.hub
  name                = var.firewall_name
  resource_group_name = var.firewall_rg_name
}

module "firewall_rules" {
  source = "../../../modules/firewall-policy"
  firewall_policy_id = data.azurerm_firewall.fw.firewall_policy_id
  network_rule_collections = var.network_rule_collections
}
