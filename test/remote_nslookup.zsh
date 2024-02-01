#!/bin/zsh

source ./variables.zsh

# SSH into the HUB VM and run nslookup
ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY_FILE} "${REMOTE_USER}@${HUB_VM}"  << EOF
echo "Hello from the Hub VM ${L1}"

if nslookup "${L0}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L0} failed"
else
    echo "nslookup ${L0} succeeded"
fi

if nslookup "${L1}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L1} succeeded"
else
    echo "nslookup ${L1} failed"
fi

if nslookup "${L2}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L2} succeeded"
else
    echo "nslookup ${L2} failed"
fi

if nslookup "${L3}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L3} succeeded"
else
    echo "nslookup ${L3} failed"
fi

if nslookup "${L4}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L4} succeeded"
else
    echo "nslookup ${L4} failed"
fi
EOF

# SSH into the Spoke Application VM and run nslookup
ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY_FILE} "${REMOTE_USER}@${SPOKE_VM}"  << EOF
echo "Hello from the Spoke Application VM ${L2}"

if nslookup "${L0}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L0} failed"
else
    echo "nslookup ${L0} succeeded"
fi

if nslookup "${L1}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L1} succeeded"
else
    echo "nslookup ${L1} failed"
fi

if nslookup "${L2}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L2} succeeded"
else
    echo "nslookup ${L2} failed"
fi

if nslookup "${L3}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L3} succeeded"
else
    echo "nslookup ${L3} failed"
fi

if nslookup "${L4}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L4} succeeded"
else
    echo "nslookup ${L4} failed"
fi
EOF


# SSH into the Spoke OnPremise VM and run nslookup
ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY_FILE} "${REMOTE_USER}@${ONPREMISE_VM}"  << EOF
echo "Hello from the Spoke OnPremise VM ${L2}"

if nslookup "${L0}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L0} failed"
else
    echo "nslookup ${L0} succeeded"
fi

if nslookup "${L1}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L1} succeeded"
else
    echo "nslookup ${L1} failed"
fi

if nslookup "${L2}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L2} succeeded"
else
    echo "nslookup ${L2} failed"
fi

if nslookup "${L3}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L3} succeeded"
else
    echo "nslookup ${L3} failed"
fi

if nslookup "${L4}" | grep -A 1 "Name:" > /dev/null; then
    echo "nslookup ${L4} succeeded"
else
    echo "nslookup ${L4} failed"
fi
EOF

