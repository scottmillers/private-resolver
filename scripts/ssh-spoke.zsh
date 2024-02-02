#!/bin/zsh
##
## Connect to the spoke VM
##
source ./variables.zsh
ssh -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${SPOKE_VM}

