// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "src/Messaging.sol";

/**
 * @notice A simple script to send a message to Starknet.
 */
contract Value is Script {
    uint256 _privateKey;
    address _contractMsgAddress;
    address _starknetMessagingAddress;
    uint256 _l2ContractAddress;
    uint256 _l2Selector;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("CONTRACT_MSG_ADDRESS");
        _starknetMessagingAddress = vm.envAddress("SN_MESSAGING_ADDRESS");
        _l2ContractAddress = vm.envUint("L2_CONTRACT_ADDRESS");
        _l2Selector = vm.envUint("L2_SELECTOR_VALUE");
    }

    function run() public{
        vm.startBroadcast(_privateKey);

        uint256[] memory payload = new uint256[](1);
        payload[0] = 1;

        console.log("Sending message to Starknet");
        console.log("Messaging address: ", _contractMsgAddress);
        console.log("L2 contract address: ", _l2ContractAddress);
        console.log("L2 selector: ", _l2Selector);

        // Remember that there is a cost of at least 20k wei to send a message.
        // Let's send 30k here to ensure that we pay enough for our payload serialization.
        Messaging(_contractMsgAddress).sendMessage{value: 30000}(
            _l2ContractAddress,
            _l2Selector,
            payload);

        vm.stopBroadcast();
    }
}

/**
 * @notice A simple script to send a message to Starknet.
 */
contract Struct is Script {
    uint256 _privateKey;
    address _contractMsgAddress;
    address _starknetMessagingAddress;
    uint256 _l2ContractAddress;
    uint256 _l2Selector;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("CONTRACT_MSG_ADDRESS");
        _starknetMessagingAddress = vm.envAddress("SN_MESSAGING_ADDRESS");
        _l2ContractAddress = vm.envUint("L2_CONTRACT_ADDRESS");
        _l2Selector = vm.envUint("L2_SELECTOR_STRUCT");
    }

    function run() public{
        vm.startBroadcast(_privateKey);

        uint256[] memory payload = new uint256[](2);
        payload[0] = 1;
        payload[1] = 2;

        // Remember that there is a cost of at least 20k wei to send a message.
        // Let's send 30k here to ensure that we pay enough for our payload serialization.
        Messaging(_contractMsgAddress).sendMessage{value: 30000}(
            _l2ContractAddress,
            _l2Selector,
            payload);

        vm.stopBroadcast();
    }
}
