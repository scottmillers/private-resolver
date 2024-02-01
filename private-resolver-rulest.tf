
# create a virtual network link between the hub virtual network and the private dns rules
resource "azurerm_private_dns_resolver_virtual_network_link" "hub-resolver-link" {
  name                      = "hub-resolver-link"
  dns_forwarding_ruleset_id = module.vnet-hub.private_resolver_ruleset_id
  virtual_network_id        = module.vnet-hub.vnet_id
}

# create a virtual network link between the application spoke and the private resolver dns rules
resource "azurerm_private_dns_resolver_virtual_network_link" "spoke-applicationn-resolver-link" {
  name                      = "dns-resolver-link-application"
  dns_forwarding_ruleset_id = module.vnet-hub.private_resolver_ruleset_id
  virtual_network_id        = module.vnet-spoke-application.vnet_id
}