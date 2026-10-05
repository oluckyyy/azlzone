resource "azurerm_virtual_network" "hub" {
  name                = var.vnet_hub
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
  address_space       = ["10.20.0.0/16"]
}

# Generic shared-services subnet (adjust/copy as needed)
resource "azurerm_subnet" "hub_shared" {
  name                 = "snet-shared"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.20.10.0/24"]
}

# Optional: extra infra subnet (safe to keep; remove if not needed)
resource "azurerm_subnet" "hub_infra" {
  name                 = "snet-infra"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.20.20.0/24"]
}
