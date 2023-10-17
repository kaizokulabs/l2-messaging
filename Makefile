ETH_RPC_URL=http://localhost:8545

##
# Messaging Makefile.
#
# Only for local testing on Katana and Anvil as addresses are pre-computed.
ACCOUNT_FILE=starknet/katana-0.json
ACCOUNT_ADDR=0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973
ACCOUNT_PRIVATE_KEY=0x1800000000300000180000000000030000000000003006001800006600

# The address of testing contract on Anvil, it's fixed as Anvil seed is not modified
# from default.
L1_CONTRACT_ADDR=0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

# The deployed address on Katana is also pre-computed. So if you change the contract,
# please consider changing this value too as the contract class will change.
CONTRACT_MSG_ADDR=0x05528d572fdd2e8f9d5e3fafda3b038fdfff6188d6797f6096004c941d080800

OPTS := --account ${ACCOUNT_FILE} \
	--rpc http://0.0.0.0:5050 \
	--private-key ${ACCOUNT_PRIVATE_KEY}

send_msg_value_l2:
	docker exec -it l2_messaging_eth bash -c "cd /ethereum && /root/.foundry/bin/forge script script/SendMessage.s.sol:Value --broadcast --rpc-url ${ETH_RPC_URL}"

send_msg_value_l1:
	docker exec -it l2_messaging_stark /root/.starkli/bin/starkli invoke ${CONTRACT_MSG_ADDR} send_message_value ${L1_CONTRACT_ADDR} 1 ${OPTS}
