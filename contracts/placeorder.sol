// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./ownable.sol";
import "./safemath.sol";
import "./ordersdata.sol";

contract PlaceOrder is Ownable, OrdersData {
    using SafeMath for uint256;

    uint transactionNumber = 0;

    function placeOrder(uint price, uint duration, string memory licensePlate) external onlyOwner returns(uint) {
        bytes32 licensePlateHash = keccak256(abi.encodePacked(licensePlate));
        transactionNumber = transactionNumber.add(1);
        orders.push(Order(price, duration, licensePlateHash));
        uint orderId = orders.length.sub(1);
        Order storage newOrder = orders[orderId];
        transactionNumberToOrder[transactionNumber] = newOrder;
        return transactionNumber;
    }
}