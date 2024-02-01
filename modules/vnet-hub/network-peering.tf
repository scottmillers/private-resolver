// Setup vnet peering between this network and any other passed in networks
/*resource "azurerm_virtual_network_peering" "vnet-hub_to_vnet" {
  name                         = "vnet-hub_to_vnet-spoke-onprem"
  count = length(var.vnet_network_peer_ids)
  resource_group_name          = var.resource_group_name
  virtual_network_name         = vnet-hub.vnet_name
  remote_virtual_network_id    = module.vnet-spoke-onprem.vnet_id
  allow_virtual_network_access = true
}
*/


resource "azurerm_virtual_network_peering" "vnet-hub_to_vnet" {
  count                        = length(var.peerings)
  name                         = var.peerings[count.index].name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id    = var.peerings[count.index].remote_virtual_network_id
  allow_virtual_network_access = var.peerings[count.index].allow_virtual_network_access
}

