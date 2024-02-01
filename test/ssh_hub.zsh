#!/bin/zsh
##
## Connect to the hub VM
##
source ./variables.zsh
ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${HUB_VM}


