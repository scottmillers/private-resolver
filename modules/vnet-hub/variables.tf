# add a variable to pass in the resource group name
variable "resource_group_name" {
  description = "value of the resource group name"
  type        = string
}

variable "region" {
  description = "value of the azure region to put the resources"
  type        = string
}

variable "peerings" {
  description = "List of VNet peers to peer with"
  type = list(object({
    name                         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = bool
  }))
  default = []
}

variable "vnet_network_peer_ids" {
  description = "list of vnets ids to peer with"
  type        = list(string)
  default     = []
}

# add a variable for the login username
variable "vm_username" {
  description = "value of the ssh username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "value of the ssh public key"
  type        = string
}

variable "private_dns_zone_name" {
  description = "name of the private zone"
  type        = string
  default     = "bep.hhs.gov"
}





