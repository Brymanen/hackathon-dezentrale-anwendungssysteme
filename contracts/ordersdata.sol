// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract OrdersData {
    
    struct Order {
        uint price;
        uint duration;
        bytes32 licensePlateHash;
    }
}