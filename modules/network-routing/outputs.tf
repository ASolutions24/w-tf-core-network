output "route_table_ids" {
  value = { for k, v in azurerm_route_table.rt : k => v.id }
}