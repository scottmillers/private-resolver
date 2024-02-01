# Create the first virtual network that simulates the Hub
resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  address_space       = ["10.0.0.0/24"]
  location            = var.region
  resource_group_name = var.resource_group_name
}




# create a subnet for the private resolver outbound DNS subnet endpoint
resource "azurerm_subnet" "snet-dns-outbound" {
  name                 = "snet-dns-outbound"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.16/28"]
  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}


# create a subnet for the private resolver inbound DNS subnet endpoint
resource "azurerm_subnet" "snet-dns-inbound" {
  name                 = "snet-dns-inbound"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.0/28"]
  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}


# create a subnet for the vm
resource "azurerm_subnet" "snet-vm" {
  name                 = "snet-vm"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefixes     = ["10.0.0.32/28"]
}


# create a security rule for the vm
resource "azurerm_network_security_group" "nsg-snet-vm" {
  name                = "nsg-snet-vm"
  location            = var.region
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "allow_ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_dns"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_icmp"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}


# associate the NSG to the subnet
resource "azurerm_subnet_network_security_group_association" "nsg-associate-snet-vm" {
  subnet_id                 = azurerm_subnet.snet-vm.id
  network_security_group_id = azurerm_network_security_group.nsg-snet-vm.id
}


