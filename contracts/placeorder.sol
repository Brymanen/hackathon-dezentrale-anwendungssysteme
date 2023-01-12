// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./ownable.sol";
import "./safemath.sol";
import "./ordersdata.sol";

contract PlaceOrder is Ownable {
    using SafeMath for uint256;
    OrdersData.Order[] public orders;
    mapping (uint => OrdersData.Order) public transactionNumberToOrder;

    uint transactionNumber = 0;

    function placeOrder(uint price, uint duration, string memory licensePlate) external onlyOwner returns(uint) {
        bytes32 licensePlateHash = keccak256(abi.encodePacked(licensePlate));
        transactionNumber = transactionNumber.add(1);
        orders.push(OrdersData.Order(price, duration, licensePlateHash));
        uint orderId = orders.length.add(1);
        OrdersData.Order storage newOrder = orders[orderId];
        transactionNumberToOrder[transactionNumber] = newOrder;
        return transactionNumber;
    }
}