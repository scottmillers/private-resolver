#!/bin/zsh
##
## Connect to the on-premise VM
##
source ./variables.zsh
ssh -i ${PRIVATE_KEY_FILE}  ${REMOTE_USER}@${ONPREMISE_VM}

