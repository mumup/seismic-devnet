#!/bin/bash

# Enter the contract directory
cd /app/packages/contract/

# check if deploy
if [ "$DEPLOY_CONTRACT" = "true" ]; then
    echo "Starting contract deployment..."
    bash script/deploy.sh
fi

# Enter the CLI directory
cd /app/packages/cli/

# Check if a transaction needs to be sent
if [ "$SEND_TRANSACTIONS" = "true" ]; then
    echo "Starting transactions..."
    bash script/transact.sh
fi

# If only to enter the container
if [ "$1" = "shell" ]; then
    exec /bin/bash
else
    echo "Container is running. To interact manually, use:"
    echo "docker exec -it <container-id> bash"
    sleep infinity
fi