output "firewall_private_ip" {
  value = azurerm_firewall.fw.ip_configuration[0].private_ip_address
}

output "firewall_id" {
  value = azurerm_firewall.fw.id
}

output "firewall_policy_id" {
  value = azurerm_firewall_policy.fw_policy.base_policy_id
}