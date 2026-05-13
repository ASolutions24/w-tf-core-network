variable "route_table_ids" {
  type = map(string)
}

variable "routes" {
  type = map(list(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
    next_hop_ip    = optional(string)
  })))
}

locals {
  routes_flat = flatten([
    for subnet_key, routes in var.routes : [
      for r in routes : {
        key        = "${subnet_key}-${r.name}"
        subnet_key = subnet_key
        route      = r
      }
    ]
  ])
}

resource "azurerm_route" "route" {
  for_each = {
    for r in local.routes_flat : r.key => r
  }

  name                   = each.value.route.name
  resource_group_name    = split("/", var.route_table_ids[each.value.subnet_key])[4]
  route_table_name       = split("/", var.route_table_ids[each.value.subnet_key])[8]
  address_prefix         = each.value.route.address_prefix
  next_hop_type          = each.value.route.next_hop_type
  next_hop_in_ip_address = try(each.value.route.next_hop_ip, null)
}