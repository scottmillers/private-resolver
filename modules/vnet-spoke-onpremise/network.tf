# Create a vnet for the onprem spoke
resource "azurerm_virtual_network" "vnet-spoke-onprem" {
  name                = "vnet-onprem-spoke"
  location            = var.region
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "snet-vm-onprem" {
  name                 = "snet-onprem-vm"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-onprem.name
  address_prefixes     = ["10.0.2.0/28"]

}

#Create a NSG for the onprem spoke
resource "azurerm_network_security_group" "snet-nsg-onprem" {
  name                = "snet-nsg-onprem"
  location            = var.region
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_rdp"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
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

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}


# associate the NSG to the network interface
resource "azurerm_subnet_network_security_group_association" "sg-associate-dns-onprem" {
  subnet_id                 = azurerm_subnet.snet-vm-onprem.id
  network_security_group_id = azurerm_network_security_group.snet-nsg-onprem.id
}



