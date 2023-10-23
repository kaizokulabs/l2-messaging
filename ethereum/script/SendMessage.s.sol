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
    uint256 _l2ContractAddress;
    uint256 _l2Selector;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("ETH_MSG_ADDR");
        _l2ContractAddress = vm.envUint("SN_CONTRACT_ADDR");
        _l2Selector = vm.envUint("SN_CONTRACT_SELECTOR");
    }

    function run() public {
        vm.startBroadcast(_privateKey);

        uint256[] memory payload = new uint256[](3);
        payload[0] = uint256(uint160(msg.sender));
        payload[1] = 1;
        payload[2] = 3;

        console.log("Sending message to Starknet");
        console.log("Messaging address: ", _contractMsgAddress);
        console.log("L2 contract address: ", _l2ContractAddress);
        console.log("L2 selector: ", _l2Selector);

        // Remember that there is a cost of at least 20k wei to send a message.
        // Let's send 30k here to ensure that we pay enough for our payload serialization.
        Messaging(_contractMsgAddress).sendMessage{value: 30000}(_l2ContractAddress, _l2Selector, payload);

        vm.stopBroadcast();
    }
}
