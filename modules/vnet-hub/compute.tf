

######################
# Virtual Machine One
######################
# create a virtual machine

# create a public ip address for the vm
resource "azurerm_public_ip" "publicip-vm-one" {
  name                = "publicip-vm-one"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# create a network interface for the vm
resource "azurerm_network_interface" "nic-vm-one" {
  name                = "nic-vm-one"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm-one-ipconfig"
    subnet_id                     = azurerm_subnet.snet-vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip-vm-one.id
  }
}



# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm-one" {
  name                  = "vm-one"
  location              = var.region
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic-vm-one.id]
  size                  = "Standard_DS1_v2"
  computer_name         = "hub-vmone"
  admin_username        = var.vm_username

  os_disk {
    name                 = "vmone-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }


  admin_ssh_key {
    username   = var.vm_username
    public_key = var.ssh_public_key
  }

}
