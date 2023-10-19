// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

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
    function consumeMessage(uint256 fromAddress, uint256[] calldata payload) external {
        // Will revert if the message is not consumable.
        _snMessaging.consumeMessageFromL2(fromAddress, payload);

        // The previous call returns the message hash (bytes32)
        // that can be used if necessary.

        // You can use the payload to do stuff here as you now know that the message is
        // valid and safe to process.
        // Remember that the payload contains cairo serialized data. So you must
        // deserialize the payload depending on the data it contains.
    }
}
