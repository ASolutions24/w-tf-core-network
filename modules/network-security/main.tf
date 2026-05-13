locals {
  nsgs = {
    for k, subnet in var.subnets :
    k => {
      name                = replace(subnet.subnet_name, "sn-", "nsg-")
      location            = subnet.location
      resource_group_name = subnet.resource_group
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each = local.nsgs

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}