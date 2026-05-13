output "private_endpoint_id" {
  value = azurerm_private_endpoint.pe.id
}

output "private_ip" {
  value = azurerm_private_endpoint.pe.private_service_connection[0].private_ip_address
}