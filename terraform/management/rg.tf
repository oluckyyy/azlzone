resource "azurerm_resource_group" "mgmt" {
  name     = var.rg_name
  location = var.location
}
