#!/bin/bash

/root/.foundry/bin/anvil &
pid=$!
sleep 2

cd /ethereum
/root/.foundry/bin/forge script script/LocalTesting.s.sol:LocalSetup --broadcast --rpc-url $ETH_RPC_URL

wait $pid
