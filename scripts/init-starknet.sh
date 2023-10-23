#!/bin/bash

load_env() {
    unamestr=$(uname)
    if [ "$unamestr" = 'Linux' ]; then
      export $(grep -v '^#' /tmp/env | xargs -d '\n')
    elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
      export $(grep -v '^#' /tmp/env | xargs -0)
    fi
}

load_env
cd /starknet

/root/.dojo/bin/katana --messaging anvil.messaging.json &
PID=$!
sleep 2

/root/.local/bin/scarb build

CLASS_HASH=`/root/.starkli/bin/starkli declare target/dev/starknet_messaging_contract_msg.sierra.json --keystore-password "" 2>&1 | grep "Declaring Cairo 1 class" | sed 's/^.*: //'`

load_env
CONTRACT_ADDRESS=`/root/.starkli/bin/starkli deploy $CLASS_HASH \
    --salt 0x1234 \
    --keystore-password "" 2>&1 | grep "The contract will be deployed at address" | sed 's/^.* //'`

# needed to avoid resource busy
cp /tmp/env /tmp/env2
sed -i "s/SN_CLASS_HASH=.*/SN_CLASS_HASH=$CLASS_HASH/g" /tmp/env2
sed -i "s/SN_CONTRACT_ADDR=.*/SN_CONTRACT_ADDR=$CONTRACT_ADDRESS/g" /tmp/env2
cat /tmp/env2 > /tmp/env

echo "SN_CONTRACT_ADDR=$CONTRACT_ADDRESS"
echo "SN_CLASS_HASH=$CLASS_HASH"

wait $PID
