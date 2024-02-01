#!/bin/zsh
##
## Connect to the on-premise VM
##
source ./variables.zsh
ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${ONPREMISE_VM}

