#!/bin/bash

cd /starknet

/root/.dojo/bin/katana --messaging anvil.messaging.json &
pid=$!
sleep 2

source katana.env
/root/.local/bin/scarb build

/root/.starkli/bin/starkli declare target/dev/starknet_messaging_contract_msg.sierra.json --keystore-password ""

/root/.starkli/bin/starkli deploy 0x00d1e9a75ed754f4ee6579312737ee59086d4992e3303a2ea3413a060f49be5f \
    --salt 0x1234 \
    --keystore-password ""

wait $pid
