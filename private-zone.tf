# Create a private dns zone and put it in the hub resource group
resource "azurerm_private_dns_zone" "private-dns-zone" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.rg-hub-vnet.name
}


# Create a virtual network link between the application spoke virtual network and the private dns zone and setup autoregisteration
resource "azurerm_private_dns_zone_virtual_network_link" "hub-private-dns-zone-link" {
  name                  = "hub-private-dns-zone-link"
  resource_group_name   = azurerm_resource_group.rg-hub-vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone.name
  virtual_network_id    = module.vnet-hub.vnet_id
  registration_enabled  = true
}



# Create a virtual network link between the hub virtual network and the private dns zone and setup autoregisteration
resource "azurerm_private_dns_zone_virtual_network_link" "application-private-dns-zone-link" {
  name                  = "application-private-dns-zone-link"
  resource_group_name   = azurerm_resource_group.rg-hub-vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone.name
  virtual_network_id    = module.vnet-spoke-application.vnet_id
  registration_enabled  = true
}