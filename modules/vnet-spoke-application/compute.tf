

######################
# Virtual Machine One
######################
# create a virtual machine



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

# create a public ip address for the vm
resource "azurerm_public_ip" "publicip-vm-one" {
  name                = "publicip-vm-one"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Dynamic"
}




# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm-one" {
  name                  = "vm-one"
  location              = var.region
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic-vm-one.id]
  size                  = "Standard_DS1_v2"
  computer_name         = "spoke-app-vmone"
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

# Solution to return the public ip address of the vm
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip.html
data "azurerm_public_ip" "public-ip-vm-one" {
  name                = azurerm_public_ip.publicip-vm-one.name
  resource_group_name = var.resource_group_name
}

#output "public_ip_address" {
#  value = data.azurerm_public_ip.example.ip_address
#}

/*
resource "azurerm_virtual_machine_extension" "ext-vm-one" {
  name                 = "ext-vm-one"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-one.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "script": "${base64encode(file("${path.module}/scripts/setup.sh"))}"
 
 }
SETTINGS
}
*/