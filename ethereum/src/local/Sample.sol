// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Sample {
    function sum_payload(uint256[] calldata payload) external pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < payload.length; i++) {
            sum += payload[i];
        }

        return sum;
    }
}
