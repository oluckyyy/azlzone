resource "azurerm_virtual_network" "spoke" {
  name                = var.vnet_spoke
  resource_group_name = azurerm_resource_group.spoke.name
  location            = var.location
  address_space       = ["10.21.0.0/16"]
}

# App subnet (expand with more as needed)
resource "azurerm_subnet" "spoke_web" {
  name                 = "snet-web"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = ["10.21.1.0/24"]
}
