// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

import "src/Messaging.sol";

/**
 * @notice A simple script to consume a message from Starknet.
 */
contract Value is Script {
    uint256 _privateKey;
    address _contractMsgAddress;
    uint256 _l2Account;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("CONTRACT_MSG_ADDRESS");
        _l2Account = vm.envUint("L2_ACCOUNT");
    }

    function run() public {
        vm.startBroadcast(_privateKey);

        // This value must match what was sent from starknet.
        // In our example, we have sent the value 1 with starkli.
        uint256[] memory payload = new uint256[](1);
        payload[0] = 1;

        // The address must be the address that has sent the message.
        // In out case, it's the katana account 0.
        Messaging(_contractMsgAddress).consumeMessage(_l2Account, payload);

        vm.stopBroadcast();
    }
}

/**
 * @notice A simple script to consume a message from Starknet.
 */
contract Struct is Script {
    uint256 _privateKey;
    address _contractMsgAddress;
    uint256 _l2Account;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("CONTRACT_MSG_ADDRESS");
        _l2Account = vm.envUint("L2_ACCOUNT");
    }

    function run() public {
        vm.startBroadcast(_privateKey);

        // In the example, we've sent a message with serialize MyData.
        uint256[] memory payload = new uint256[](2);
        payload[0] = 1;
        payload[1] = 2;

        Messaging(_contractMsgAddress).consumeMessage(_l2Account, payload);

        vm.stopBroadcast();
    }
}
