// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "src/Messaging.sol";

/**
 * @notice A simple script to consume a message from Starknet.
 */
contract Consume is Script {
    uint256 _privateKey;
    address _contractMsgAddress;
    uint256 _l2Account;

    function setUp() public {
        _privateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");
        _contractMsgAddress = vm.envAddress("ETH_MSG_ADDR");
        _l2Account = vm.envUint("SN_ACCOUNT_ADDR");
    }

    function run() public {
        vm.startBroadcast(_privateKey);

        uint256[] memory payload = new uint256[](4);
        payload[0] = 0;
        payload[1] = 0;
        payload[2] = 0;
        payload[3] = 0;

        Messaging(_contractMsgAddress).consumeMessage(_l2Account, payload);

        vm.stopBroadcast();
    }
}
