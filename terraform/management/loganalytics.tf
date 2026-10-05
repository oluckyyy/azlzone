resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  resource_group_name = azurerm_resource_group.mgmt.name
  location            = azurerm_resource_group.mgmt.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
output "law_id" { value = azurerm_log_analytics_workspace.law.id }
output "law_name" { value = azurerm_log_analytics_workspace.law.name }
