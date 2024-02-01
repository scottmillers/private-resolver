# Create the first virtual network that simulates the Hub
resource "azurerm_virtual_network" "vnet-spoke-application" {
  name                = "vnet-spoke-application"
  address_space       = ["10.0.4.0/24"]
  location            = var.region
  resource_group_name = var.resource_group_name
}


# create a subnet for the vm and allow it to access the storage account through a private endpoint
resource "azurerm_subnet" "snet-vm" {
  name                                      = "snet-vm"
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = azurerm_virtual_network.vnet-spoke-application.name
  address_prefixes                          = ["10.0.4.0/28"]
  private_endpoint_network_policies_enabled = true # this is required to allow the private endpoint to access the storage account
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


