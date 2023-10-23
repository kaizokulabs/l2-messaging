// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "src/Messaging.sol";

/**
 * @notice A simple script to send a message to Starknet.
 */
contract Send is Script {
    uint256 _privateKey;
    address _contractMsgAddress;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("ETH_MSG_ADDR");
    }

    function run(uint256 l2_addr, uint256 l2_selector, uint256[] calldata args) public {
        vm.startBroadcast(_privateKey);

        uint256[] memory payload = new uint256[](args.length + 1);

        payload[0] = uint256(uint160(msg.sender));
        for (uint256 i = 0; i < args.length; i++) {
            payload[i + 1] = args[i];
        }

        console.log("Sending message to Starknet");
        console.log("Messaging address: ", _contractMsgAddress);
        console.log("L2 contract address: ", l2_addr);
        console.log("L2 selector: ", l2_selector);
        console.log("Payload: ", args[0]);
        console.log("Payload: ", args[1]);

        // Remember that there is a cost of at least 20k wei to send a message.
        // Let's send 30k here to ensure that we pay enough for our payload serialization.
        Messaging(_contractMsgAddress).sendMessage{value: 30000}(l2_addr, l2_selector, payload);

        vm.stopBroadcast();
    }
}

contract Consume is Script {
    uint256 _privateKey;
    address _contractMsgAddress;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("ETH_MSG_ADDR");
    }

    function run(uint256[] calldata args) public {
        vm.startBroadcast(_privateKey);

        console.log("Consuming message from Starknet");
        console.log("Messaging address: ", _contractMsgAddress);
        console.log("L2 contract address: ", _l2_addr);
        console.log("Payload: ", args[0]+args[1]);

        uint256[] memory payload = new uint256[](5);
        payload[0] = 137122462167341575662000267002353578582749290296;
        payload[1] = 8243121641139480617;
        payload[2] = 0;
        payload[3] = 1;
        payload[4] = args[0]+args[1];

        Messaging(_contractMsgAddress).consumeMessage(0x0, payload);

        vm.stopBroadcast();
    }
}
