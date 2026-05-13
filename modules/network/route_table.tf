resource "azurerm_route_table" "rt" {
  for_each = {
    for subnet in local.subnets :
    subnet.route_table_name => subnet
    if subnet.route_table_name != null
  }

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group
}