# add a variable to pass in the resource group name
variable "resource_group_name" {
  description = "value of the resource group name"
  type        = string
  default     = "private-resolver-prototype"
}
# add a variable to pass in the azure region
variable "region" {
  description = "value of the azure region to put the resources"
  type        = string
  default     = "centralus"
}

// add a object to allow peering 
variable "peerings" {
  description = "List of VNet peers to peer with"
  type = list(object({
    name                         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = bool
  }))
  default = []
}

# add a variable for the login username
variable "dns_admin_username" {
  description = "value of the dns server username"
  type        = string
  default     = "azureuser"
}

variable "dns_admin_password" {
  description = "value of the dns server password"
  type        = string
  default     = "P@ssw0rd1234"
}

variable "Domain_DNSName" {
  description = "FQDN for the Active Directory forest root domain"
  type        = string
  sensitive   = false
  default     = "onpremise.hhs.gov"
}

variable "dns_interal_ip_address" {
  description = "value of the dns server internal ip address"
  type        = string
  default     = "10.0.2.10"
}

# add a variable for the login username
variable "vm_username" {
  description = "value of the ssh username"
  type        = string
  default     = "azureuser"
}

variable "vm_internal_ip_address" {
  description = "value of the vm internal ip address"
  type        = string
  default     = "10.0.2.14"
}

variable "ssh_public_key" {
  description = "value of the ssh public key"
  type        = string
}

