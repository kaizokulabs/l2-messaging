// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "src/Messaging.sol";

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

        uint256[] memory payload = new uint256[](3);
        payload[0] = 1;
        payload[1] = 2;
        payload[2] = 3;

        uint256 result = Messaging(_contractMsgAddress).consumeMessage(_l2Account, payload);
        console.log("Result:", result);

        vm.stopBroadcast();
    }
}
