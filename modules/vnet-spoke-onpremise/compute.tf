# create a public ip address for the dns
resource "azurerm_public_ip" "publicip-dns-onprem" {
  name                = "publicip-dns-onprem"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# create a network interface for the dns
resource "azurerm_network_interface" "nic-dns-onprem" {
  name                = "nic-dns-onprem"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet-vm-onprem.id
    private_ip_address_allocation = "Static" # Set to "static" to support DNS
    private_ip_address            = var.dns_interal_ip_address
    public_ip_address_id          = azurerm_public_ip.publicip-dns-onprem.id
  }
}




# create a windows virtual machine with a dns
resource "azurerm_windows_virtual_machine" "dns-onprem" {
  name                = "dns-onprem"
  resource_group_name = var.resource_group_name
  location            = var.region
  size                = "Standard_D2s_v3"
  admin_username      = var.dns_admin_username
  admin_password      = var.dns_admin_password
  computer_name       = "hhsdns"
  network_interface_ids = [
    azurerm_network_interface.nic-dns-onprem.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }


}


#Variable input for the DNS.ps1 script
data "template_file" "DNS" {
  template = file("${path.module}/scripts/Install-DNS.ps1")
  vars = {
    Domain_DNSName = "${var.Domain_DNSName}"
  }
}

# Install a DNS server on the virtual machine
# https://techcommunity.microsoft.com/t5/itops-talk-blog/how-to-run-powershell-scripts-on-azure-vms-with-terraform/ba-p/3827573
resource "azurerm_virtual_machine_extension" "install_dns" {
  name                 = "install_dns"
  virtual_machine_id   = azurerm_windows_virtual_machine.dns-onprem.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.DNS.rendered)}')) | Out-File -filepath DNS.ps1\" && powershell -ExecutionPolicy Unrestricted -File DNS.ps1 -Domain_DNSName ${data.template_file.DNS.vars.Domain_DNSName}" 
  }
  SETTINGS
}


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
    subnet_id                     = azurerm_subnet.snet-vm-onprem.id
    private_ip_address_allocation = "Static" # Set to "static" to support DNS
    private_ip_address            = var.vm_internal_ip_address
    public_ip_address_id          = azurerm_public_ip.publicip-vm-one.id
  }

  dns_servers = [var.dns_interal_ip_address]
}



# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm-one" {
  name                  = "vm-one"
  location              = var.region
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic-vm-one.id]
  size                  = "Standard_DS1_v2"
  computer_name         = "vmone"
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

data "azurerm_public_ip" "public-ip-vm-one" {
  name                = azurerm_public_ip.publicip-vm-one.name
  resource_group_name = var.resource_group_name
}

# for Windows VM's you can only run one custom script extension

#Variable input for the DNS.ps1 script
/*data "template_file" "SSH" {
  template = file("${path.module}/scripts/Install-SSH.ps1")
  vars = {
    ssh_public_key = "${var.ssh_public_key}"
  }
}

resource "azurerm_virtual_machine_extension" "install_ssh" {
  name                 = "install_ssh"
  virtual_machine_id   = azurerm_windows_virtual_machine.dns-onprem.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.SSH.rendered)}')) | Out-File -filepath SSH.ps1\" && powershell -ExecutionPolicy Unrestricted -File SSH.ps1 -Domain_DNSName ${data.template_file.SSH.vars.ssh_public_key}" 
  }
  SETTINGS
}
*/


#Variable input for the DNS.ps1 script
/*data "template_file" "TIME" {
  template = file("${path.module}/scripts/Set-TimeZone.ps1")
}

resource "azurerm_virtual_machine_extension" "set_timezone" {
  name                 = "set_timezone"
  virtual_machine_id   = azurerm_windows_virtual_machine.dns-onprem.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.TIME.rendered)}')) | Out-File -filepath TIME.ps1\" && powershell -ExecutionPolicy Unrestricted -File TIME.ps1" 
  }
  SETTINGS
}

*/

# Install IIS web server to the virtual machine
/*resource "azurerm_virtual_machine_extension" "web_server_install" {
  name                       = "${random_pet.prefix.id}-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}
*/



