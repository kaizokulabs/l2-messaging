#!/bin/bash

cd /starknet

/root/.dojo/bin/katana --messaging anvil.messaging.json
sleep 2

source katana.env
/root/.local/bin/scarb build

/root/.starkli/bin/starkli declare target/dev/starknet_messaging_contract_msg.sierra.json --keystore-password ""

/root/.starkli/bin/starkli deploy 0x048ffd12e3e126938f0695eef1357eb7c45677e65d947cf4891b9598637703ca \
    --salt 0x1234 \
    --keystore-password ""
