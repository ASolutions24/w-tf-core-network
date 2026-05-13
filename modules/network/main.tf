locals {
  subnets = flatten([
    for vnet_name, vnet in var.vnets : [
      for subnet_name, subnet in vnet.subnets : {
        key              = "${vnet_name}-${subnet_name}"
        vnet_name        = vnet_name
        subnet_name      = subnet_name
        resource_group   = vnet.resource_group_name
        location         = vnet.location
        address_prefixes = subnet.address_prefixes
        nsg_name         = try(subnet.nsg_name, null)
        route_table_name = try(subnet.route_table_name, null)
      }
    ]
  ])
}