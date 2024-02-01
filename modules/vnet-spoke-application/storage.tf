resource "azurerm_storage_account" "nslookup-storage-account" {
  name                     = "nslookupstorageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_private_endpoint" "private-endpoint-storage-account" {
  name                = "private-endpoint-storage-account"
  resource_group_name = var.resource_group_name
  location            = var.region
  subnet_id           = azurerm_subnet.snet-vm.id
  private_service_connection {
    name                           = "private-endpoint-storage-account"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.nslookup-storage-account.id
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "add_to_azure_private_dns"
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}


resource "azurerm_storage_table" "nslookup-table" {
  name                 = "nslookuptable"
  storage_account_name = azurerm_storage_account.nslookup-storage-account.name
}


/* removing since it is not needed
resource "azurerm_storage_account_network_rules" "storage-account-network-rules" {
  storage_account_id         = azurerm_storage_account.nslookup-storage-account.id
  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = [azurerm_subnet.snet-vm.id]
  bypass                     = ["None"]
}
*/




