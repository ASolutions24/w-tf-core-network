locals {
  filtered_subnets = {
    for k, v in var.subnet_ids :
    k => v
    if !endswith(k, "AzureFirewallSubnet")
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  for_each = local.filtered_subnets

  subnet_id                 = each.value
  network_security_group_id = var.nsg_ids[each.key]
}

resource "azurerm_subnet_route_table_association" "rt" {
  for_each = local.filtered_subnets

  subnet_id      = each.value
  route_table_id = var.route_table_ids[each.key]
}