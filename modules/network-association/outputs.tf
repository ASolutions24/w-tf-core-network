output "nsg_assoc_ids" {
  value = {
    for k, v in azurerm_subnet_network_security_group_association.nsg : k => v.id
  }
}