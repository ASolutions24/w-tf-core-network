locals {
  route_tables = {
    for k, subnet in var.subnets :
    k => {
      name                = replace(subnet.subnet_name, "sn-", "rt-")
      location            = subnet.location
      resource_group_name = subnet.resource_group
    }
  }
}

resource "azurerm_route_table" "rt" {
  for_each = local.route_tables

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}