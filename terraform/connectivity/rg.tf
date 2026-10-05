resource "azurerm_resource_group" "hub" {
  name     = var.rg_hub
  location = var.location
}

resource "azurerm_resource_group" "spoke" {
  name     = var.rg_spoke
  location = var.location
}
