#!/bin/bash

cd /starknet

/root/.dojo/bin/katana --messaging anvil.messaging.json &
pid=$!
sleep 2

source katana.env
/root/.local/bin/scarb build

/root/.starkli/bin/starkli declare target/dev/starknet_messaging_contract_msg.sierra.json --keystore-password ""

/root/.starkli/bin/starkli deploy 0x0508102abfa90aec2fa48c0eb629759a1c7ab6fa8a9297d269c4a453719a7fe0 \
    --salt 0x1234 \
    --keystore-password ""

wait $pid
