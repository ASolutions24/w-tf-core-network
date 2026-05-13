resource "azurerm_subnet" "subnet" {
  for_each = {
    for subnet in local.subnets : subnet.key => subnet
  }

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes
  default_outbound_access_enabled = false
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = {
    for subnet in local.subnets :
    subnet.key => subnet
    if subnet.nsg_name != null
  }

  subnet_id = azurerm_subnet.subnet[each.key].id

  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_name].id
}

resource "azurerm_subnet_route_table_association" "rt_assoc" {
  for_each = {
    for subnet in local.subnets :
    subnet.key => subnet
    if subnet.route_table_name != null
  }

  subnet_id      = azurerm_subnet.subnet[each.key].id
  route_table_id = azurerm_route_table.rt[each.value.route_table_name].id
}