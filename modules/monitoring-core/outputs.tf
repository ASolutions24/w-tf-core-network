output "workspace_id" {
  value = azurerm_log_analytics_workspace.this.id
}

output "workspace_workspace_id" {
  value = azurerm_log_analytics_workspace.this.workspace_id
}

output "action_group_id" {
  value = azurerm_monitor_action_group.this.id
}