#!/bin/zsh
##
## Connect to the spoke VM
##
source ./variables.zsh
ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${SPOKE_VM}

