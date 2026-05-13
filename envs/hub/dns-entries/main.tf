locals {
  records_flat = flatten([
    for zone_key, zone in var.dns_records : [
      for record in zone.records : {
        key     = "${zone_key}-${record.name}"
        zone    = zone
        record  = record
      }
    ]
  ])
}

# A Records
resource "azurerm_private_dns_a_record" "a" {
  for_each = {
    for r in local.records_flat :
    r.key => r if r.record.type == "A"
  }

  name                = each.value.record.name
  zone_name           = each.value.zone.zone_name
  resource_group_name = each.value.zone.resource_group_name
  ttl                 = each.value.record.ttl
  records             = each.value.record.values
}

# CNAME Records
resource "azurerm_private_dns_cname_record" "cname" {
  for_each = {
    for r in local.records_flat :
    r.key => r if r.record.type == "CNAME"
  }

  name                = each.value.record.name
  zone_name           = each.value.zone.zone_name
  resource_group_name = each.value.zone.resource_group_name
  ttl                 = each.value.record.ttl
  record              = each.value.record.values[0]
}