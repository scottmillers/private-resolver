output "hub_vm_public_ip_address" {
  description = "The public ip address of the hub network vm"
  value       = module.vnet-hub.vm_public_ip_address
}

output "hub_vm_user_name" {
  description = "The user name of the hub vm"
  value       = module.vnet-hub.vm_username
}

output "spoke_vm_public_ip_address" {
  description = "The public ip address of the application spoke network vm"
  value       = module.vnet-spoke-application.vm_public_ip_address
}

output "spoke_vm_user_name" {
  description = "The user name of the application spoke vm"
  value       = module.vnet-spoke-application.vm_username
}

output "onpremise_dns_public_ip_address" {
  description = "The public ip address of the dns server"
  value       = module.vnet-spoke-onpremise.dns_public_ip_address
}

output "onpremise_dns_user_name" {
  description = "The admin username of the dns server"
  sensitive   = false
  value       = module.vnet-spoke-onpremise.dns_admin_username
}

output "onpremise_dns_user_password" {
  description = "The admin password of the dns server"
  sensitive   = false
  value       = module.vnet-spoke-onpremise.dns_admin_password
}

output "onpremise_vm_public_ip_address" {
  description = "The public ip address of the onpremise vm"
  value       = module.vnet-spoke-onpremise.vm_public_ip_address
}

output "onpremise_vm_user_name" {
  description = "The public ip address of the onpremise vm"
  value       = module.vnet-spoke-onpremise.vm_public_ip_address
}
