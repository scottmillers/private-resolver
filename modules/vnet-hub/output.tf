output "vnet_id" {
  value = azurerm_virtual_network.vnet-hub.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet-hub.name
}

output "vm_public_ip_address" {
  description = "value of the vm public ip address"
  #value = data.azurerm_public_ip.public-ip-vm-one.ip_address
  value = azurerm_linux_virtual_machine.vm-one.public_ip_address
}

output "vm_computer_name" {
  description = "value of the vm computer name"
  value       = azurerm_linux_virtual_machine.vm-one.computer_name
}


output "vm_username" {
  description = "value of the vm username"
  value       = var.vm_username
  sensitive   = false
}

output "private_resolver_ruleset_id" {
  description = "value of the private dns resolver ruleset id"
  value       = azurerm_private_dns_resolver_dns_forwarding_ruleset.dns-forwarding-ruleset.id
}





