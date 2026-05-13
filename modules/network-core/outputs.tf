output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "subnet_ids" {
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.id
  }
}

output "subnets" {
  value = {
    for k, subnet in azurerm_subnet.subnet : k => {
      subnet_name      = subnet.name
      location         = azurerm_virtual_network.vnet.location
      resource_group   = azurerm_virtual_network.vnet.resource_group_name
      id               = subnet.id
    }
  }
}