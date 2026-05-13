resource "azurerm_private_dns_zone" "zone" {
  for_each = var.zones

  name                = each.value.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each = var.zones

  name                  = "${each.key}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.zone[each.key].name
  virtual_network_id    = var.vnet_id

  registration_enabled = false
}