resource "azurerm_private_endpoint" "pe" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = var.manual_connection
  }

  private_dns_zone_group {
    name = "default"

    private_dns_zone_ids = var.private_dns_zone_ids
  }

  tags = var.tags
}

# Optional DNS Zone Group (only if zones provided)
/*
resource "azurerm_private_endpoint_dns_zone_group" "dns" {
  count = length(var.private_dns_zone_ids) > 0 ? 1 : 0

  name                 = "${var.name}-dns"
  private_endpoint_id  = azurerm_private_endpoint.pe.id
  private_dns_zone_ids = var.private_dns_zone_ids
}
*/