output "inbound_ip" {
  value = azurerm_private_dns_resolver_inbound_endpoint.inbound.ip_configurations[0].private_ip_address
}

output "resolver_id" {
  value = azurerm_private_dns_resolver.resolver.id
}

output "outbound_endpoint_id" {
  value = azurerm_private_dns_resolver_outbound_endpoint.outbound.id
}