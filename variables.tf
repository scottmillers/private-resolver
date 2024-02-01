variable "region" {
  description = "Azure region"
  type        = string
  default     = "southcentralus"
}

variable "private_dns_zone_name" {
  description = "name of the private zone"
  type        = string
  default     = "bep.hhs.gov"
}

# add a variable for the login username
variable "vm_username" {
  description = "value of the ssh username"
  type        = string
  default     = "azureuser"
}
