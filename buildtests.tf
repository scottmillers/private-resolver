# Set the return values from Terraform to be used for test scripts
locals {
  variables = <<-EOT
    #!/bin/zsh
    ##
    ## variables for the ZSH shell scripts
    ##
    REMOTE_USER="${module.vnet-hub.vm_username}"
    PRIVATE_KEY_FILE="private_key.pem"

    HUB_VM="${module.vnet-hub.vm_public_ip_address}"
    SPOKE_VM="${module.vnet-spoke-application.vm_public_ip_address}"
    ONPREMISE_VM="${module.vnet-spoke-onpremise.vm_public_ip_address}"

    # Used by nslookup lookup for testing
    L0="junk.bep.hhs.gov"
    L1="${module.vnet-hub.vm_computer_name}.bep.hhs.gov"
    L2="${module.vnet-spoke-application.vm_computer_name}.bep.hhs.gov"
    L3="${module.vnet-spoke-onpremise.vm_computer_name}.onpremise.hhs.gov"
    L4="${module.vnet-spoke-application.private_endpoint_table_fqdn}"
 

  EOT

}

resource "local_file" "output_variables" {
  content  = local.variables
  filename = "${path.module}/test/variables.zsh"
}
