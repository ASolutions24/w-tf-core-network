resource "azurerm_network_security_group" "nsg" {
  for_each = {
    for subnet in local.subnets :
    subnet.nsg_name => subnet
    if subnet.nsg_name != null
  }

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group
}
