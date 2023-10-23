#!/bin/bash

/root/.foundry/bin/anvil --host 0.0.0.0 &
PID=$!
sleep 2

cd /ethereum
/root/.foundry/bin/forge script script/LocalTesting.s.sol:LocalSetup --broadcast --rpc-url $ETH_RPC_URL

wait $PID
