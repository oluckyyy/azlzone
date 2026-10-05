# Hub -> Spoke peering
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "hub-to-spoke"
  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
  use_remote_gateways          = false
}

# Spoke -> Hub peering
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "spoke-to-hub"
  resource_group_name       = azurerm_resource_group.spoke.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
  use_remote_gateways          = false
}
