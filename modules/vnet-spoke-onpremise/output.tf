output "vnet_id" {
  value = azurerm_virtual_network.vnet-spoke-onprem.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet-spoke-onprem.name
}

output "dns_public_ip_address" {
  value = azurerm_windows_virtual_machine.dns-onprem.public_ip_address
}

output "dns_admin_username" {
  sensitive = false
  value     = var.dns_admin_username
}

output "dns_admin_password" {
  sensitive = false
  value     = var.dns_admin_password
}


output "vm_public_ip_address" {
  value = azurerm_linux_virtual_machine.vm-one.public_ip_address
}

output "vm_computer_name" {
  description = "value of the vm computer name"
  value       = azurerm_linux_virtual_machine.vm-one.computer_name
}

output "vm_username" {
  sensitive = false
  value     = var.vm_username
}

