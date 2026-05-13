resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "ruleset" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  private_dns_resolver_outbound_endpoint_ids = [
    var.outbound_endpoint_id
  ]
}

resource "azurerm_private_dns_resolver_forwarding_rule" "rule" {
  for_each = {
    for r in var.rules : r.name => r
  }

  name                      = each.value.name
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.ruleset.id
  domain_name               = each.value.domain_name
  enabled                   = true

  dynamic "target_dns_servers" {
    for_each = each.value.target_dns_servers

    content {
      ip_address = target_dns_servers.value.ip
      port       = target_dns_servers.value.port
    }
  }
}

resource "azurerm_private_dns_resolver_virtual_network_link" "link" {
  name                      = "${var.name}-link"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.ruleset.id
  virtual_network_id        = var.vnet_id
}