/*
locals {
  rules_flat = flatten([
    for subnet_key, rules in var.rules : [
      for rule in rules : {
        key        = "${subnet_key}-${rule.name}"
        subnet_key = subnet_key
        rule       = rule
      }
    ]
  ])
}

resource "azurerm_network_security_rule" "rule" {
  for_each = {
    for r in local.rules_flat : r.key => r
  }

  name                        = each.value.rule.name
  priority                    = each.value.rule.priority
  direction                   = each.value.rule.direction
  access                      = each.value.rule.access
  protocol                    = each.value.rule.protocol
  source_port_range           = each.value.rule.source_port_range
  destination_port_range      = each.value.rule.destination_port_range
  source_address_prefix       = each.value.rule.source_address_prefix
  destination_address_prefix  = each.value.rule.destination_address_prefix

  resource_group_name         = split("/", var.nsg_ids[each.value.subnet_key])[4]
  network_security_group_name = split("/", var.nsg_ids[each.value.subnet_key])[8]
}
*/

locals {
  rules_flat = flatten([
    for nsg_key, rules in var.rules : [
      for rule in rules : {
        key     = "${nsg_key}-${rule.name}"
        nsg_key = nsg_key
        rule    = rule
      }
    ]
  ])
}

resource "azurerm_network_security_rule" "rule" {
  for_each = {
    for r in local.rules_flat : r.key => r
  }

  name                       = each.value.rule.name
  priority                   = each.value.rule.priority
  direction                  = each.value.rule.direction
  access                     = each.value.rule.access
  protocol                   = each.value.rule.protocol
  source_port_range          = each.value.rule.source_port_range
  destination_port_range     = each.value.rule.destination_port_range
  source_address_prefix      = each.value.rule.source_address_prefix
  destination_address_prefix = each.value.rule.destination_address_prefix

  resource_group_name         = var.nsgs[each.value.nsg_key].resource_group_name
  network_security_group_name = var.nsgs[each.value.nsg_key].name
}