// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "src/Messaging.sol";
import "src/local/Sample.sol";
import "src/local/StarknetMessagingLocal.sol";

/**
 * Deploys the ContractMsg and StarknetMessagingLocal contracts.
 *    Very handy to quickly setup Anvil to debug.
 */
contract LocalSetup is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("ACCOUNT_PRIVATE_KEY");

        string memory json = "local_testing";

        vm.startBroadcast(deployerPrivateKey);

        address snLocalAddress = address(new StarknetMessagingLocal());
        vm.serializeString(json, "snMessaging_address", vm.toString(snLocalAddress));

        address localAddress = address(new Sample());
        vm.serializeString(json, "sample_address", vm.toString(localAddress));
        console.log("Sample address:", vm.toString(localAddress));

        address contractMsg = address(new Messaging(snLocalAddress));
        vm.serializeString(json, "contractMsg_address", vm.toString(contractMsg));

        vm.stopBroadcast();

        string memory data = vm.serializeBool(json, "success", true);

        string memory localLogs = "./logs/";
        vm.createDir(localLogs, true);
        vm.writeJson(data, string.concat(localLogs, "local_setup.json"));
    }
}
