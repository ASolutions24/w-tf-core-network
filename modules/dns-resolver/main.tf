resource "azurerm_private_dns_resolver" "resolver" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_network_id  = var.vnet_id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound" {
  name                    = "${var.name}-inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = var.location

  ip_configurations {
    subnet_id = var.inbound_subnet_id
  }
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound" {
  name                    = "${var.name}-outbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = var.location
  subnet_id               = var.outbound_subnet_id
}