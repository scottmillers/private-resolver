# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.72.0"
    }


    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }

  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

// create the resource group for the hub virtual network
resource "azurerm_resource_group" "rg-hub-vnet" {
  name     = "hub-vnet"
  location = var.region
}

// create the resource group for the spoke application virtual network
resource "azurerm_resource_group" "rg-application-vnet" {
  name     = "application-vnet"
  location = var.region
}

// create the resource group for the spoke on-premise virtual network
resource "azurerm_resource_group" "rg-on-prem-vnet" {
  name     = "on-prem-vnet"
  location = var.region
}


// create the on-premise virtual network components
module "vnet-spoke-onpremise" {
  source              = "./modules/vnet-spoke-onpremise"
  resource_group_name = azurerm_resource_group.rg-on-prem-vnet.name
  region              = var.region
  dns_admin_username  = var.vm_username
  vm_username         = var.vm_username
  ssh_public_key      = tls_private_key.ssh.public_key_openssh
  peerings = [
    {
      name                         = "vnet-spoke-onpremise-to-hub"
      remote_virtual_network_id    = module.vnet-hub.vnet_id
      allow_virtual_network_access = true
    },
  ]
}


// create the hub virtual network components
module "vnet-hub" {
  source                = "./modules/vnet-hub"
  resource_group_name   = azurerm_resource_group.rg-hub-vnet.name
  region                = var.region
  private_dns_zone_name = azurerm_private_dns_zone.private-dns-zone.name
  vm_username           = var.vm_username
  ssh_public_key        = tls_private_key.ssh.public_key_openssh
  peerings = [
    {
      name                         = "vnet-hub-to-spoke-onpremise"
      remote_virtual_network_id    = module.vnet-spoke-onpremise.vnet_id
      allow_virtual_network_access = true
    },
    {
      name                         = "vnet-hub-to-spoke-application"
      remote_virtual_network_id    = module.vnet-spoke-application.vnet_id
      allow_virtual_network_access = true
    }
  ]
}

// create the application spoke virtual network components
module "vnet-spoke-application" {
  source               = "./modules/vnet-spoke-application"
  resource_group_name  = azurerm_resource_group.rg-application-vnet.name
  region               = var.region
  vm_username          = var.vm_username
  ssh_public_key       = tls_private_key.ssh.public_key_openssh
  private_dns_zone_ids = [azurerm_private_dns_zone.private-dns-zone.id]
  peerings = [
    {
      name                         = "vnet-spoke-application-to-hub"
      remote_virtual_network_id    = module.vnet-hub.vnet_id
      allow_virtual_network_access = true
    },
  ]
}






