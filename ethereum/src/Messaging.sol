// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/console.sol";

import {IStarknetMessaging} from "starknet/IStarknetMessaging.sol";

error InvalidPayload();

contract Messaging {
    IStarknetMessaging private _snMessaging;

    /**
     *  @param snMessaging The address of Starknet Core contract, responsible or messaging.
     */
    constructor(address snMessaging) {
        _snMessaging = IStarknetMessaging(snMessaging);
    }

    /**
     * @notice Sends a message to Starknet contract.
     *
     *    @param contractAddress The contract's address on starknet.
     *    @param selector The l1_handler function of the contract to call.
     *    @param payload The serialized data to be sent.
     *
     *    @dev Consider that Cairo only understands felts252.
     *    So the serialization on solidity must be adjusted. For instance, a uint256
     *    must be split in two uint256 with low and high part to be understood by Cairo.
     */
    function sendMessage(uint256 contractAddress, uint256 selector, uint256[] memory payload) external payable {
        _snMessaging.sendMessageToL2{value: msg.value}(contractAddress, selector, payload);
    }

    /**
     * @notice Manually consumes a message that was received from L2.
     *
     *    @param fromAddress L2 contract (account) that has sent the message.
     *    @param payload Payload of the message used to verify the hash.
     *
     *    @dev A message "receive" means that the message hash is registered as consumable.
     *    One must provide the message content, to let Starknet Core contract verify the hash
     *    and validate the message content before being consumed.
     */
    function consumeMessage(uint256 fromAddress, uint256[] calldata payload) external payable {
        _snMessaging.consumeMessageFromL2(fromAddress, payload);

        require(payload.length < 3, "Invalid payload");
        
        address dest_address = address(uint160(payload[0]));
        bytes4 selector = bytes4(uint32(payload[1]));
        uint256 amount = payload[2];
        
        require(amount > msg.value, "Invalid amount");
        
        if (amount > 0) {
            (bool success,) = payable(dest_address).call{value: amount}(abi.encodeWithSelector(selector, payload[3:]));
            if (!success) {
                revert InvalidPayload();
            }
        } else {
            (bool success,) = dest_address.call(abi.encodeWithSelector(selector, payload[3:]));
            if (!success) {
                revert InvalidPayload();
            }
        }
    }
}
