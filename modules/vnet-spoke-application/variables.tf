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


variable "peerings" {
  description = "List of VNet peers to peer with"
  type = list(object({
    name                         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = bool
  }))
  default = []
}

variable "private_dns_zone_ids" {
  description = "Private DNS zone ids to associate with the table private endpoint"
  type        = list(string)
}

variable "vm_username" {
  description = "value of the ssh username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "value of the ssh public key"
  type        = string
}






