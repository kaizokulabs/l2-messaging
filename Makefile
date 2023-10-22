include scripts/env

OPTS := --account starknet/${STARKNET_ACCOUNT} \
	--rpc http://0.0.0.0:5050 \
	--private-key ${SN_ACCOUNT_PRIVATE_KEY}

send_msg_value_l2:
	docker exec -it l2_messaging_eth bash -c "cd /ethereum && /root/.foundry/bin/forge script script/SendMessage.s.sol:Value --broadcast --rpc-url ${ETH_RPC_URL}"

.ONESHELL:
send_msg_value_l1:
	docker exec -it l2_messaging_stark /root/.starkli/bin/starkli invoke ${SN_CONTRACT_ADDR} send_message ${OPTS}
	docker exec -it l2_messaging_eth bash -c "cd /ethereum && /root/.foundry/bin/forge script script/ConsumeMessage.s.sol:Struct --broadcast --rpc-url ${ETH_RPC_URL}"
