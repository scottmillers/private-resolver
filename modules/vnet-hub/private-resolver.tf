

# Create a private resolver in the virtual network
resource "azurerm_private_dns_resolver" "private-resolver" {
  name                = "private-resolver"
  resource_group_name = var.resource_group_name
  location            = var.region
  virtual_network_id  = azurerm_virtual_network.vnet-hub.id
}



# create a private dns resolver inbound endpoint
resource "azurerm_private_dns_resolver_inbound_endpoint" "endpoint-dns-inbound" {
  name                    = "endpoint-dns-inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.private-resolver.id
  location                = var.region
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.snet-dns-inbound.id
  }

}

# create a private dns resolver output endpoint
resource "azurerm_private_dns_resolver_outbound_endpoint" "endpoint-dns-outbound" {
  name                    = "endpoint-dns-outbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.private-resolver.id
  location                = var.region
  subnet_id               = azurerm_subnet.snet-dns-outbound.id
}


# create a private dns resolver forwarding ruleset
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "dns-forwarding-ruleset" {
  name                                       = "dns-forwarding-ruleset"
  resource_group_name                        = var.resource_group_name
  location                                   = var.region
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.endpoint-dns-outbound.id]


}

# create a dns resolver forwarding rule that associates a domain with a target IP
resource "azurerm_private_dns_resolver_forwarding_rule" "dns-forwarding-rule-onpremise" {
  name                      = "dns-forwarding-rule-onpremise"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.dns-forwarding-ruleset.id
  domain_name               = "onpremise.hhs.gov."
  enabled                   = true
  target_dns_servers {
    ip_address = "10.0.2.10"
    port       = 53
  }
  metadata = {
    key = "value"
  }
}
