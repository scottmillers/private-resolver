resource "azurerm_virtual_network_peering" "vnet-onpremise_to_vnet" {
  count                        = length(var.peerings)
  name                         = var.peerings[count.index].name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet-spoke-onprem.name
  remote_virtual_network_id    = var.peerings[count.index].remote_virtual_network_id
  allow_virtual_network_access = var.peerings[count.index].allow_virtual_network_access
}

