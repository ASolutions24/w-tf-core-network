output "zone_ids" {
  value = {
    for k, v in azurerm_private_dns_zone.zone :
    k => v.id
  }
}

output "zone_names" {
  value = {
    for k, v in azurerm_private_dns_zone.zone :
    k => v.name
  }
}