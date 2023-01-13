// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./ownable.sol";
import "./safemath.sol";
import "./ordersdata.sol";
import "./parking.sol";

contract PlaceOrder is Ownable, OrdersData {
    using SafeMath for uint256;
    Order[] public orders;

    mapping (uint => Order) public transactionNumberToOrder;
    Parking parking;

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

    function getOrder(uint transactionNumber) external view onlyOwner returns(uint price, uint duration, bytes32 licensePlateHash) {
        Order storage currentOrder;
        currentOrder = transactionNumberToOrder[transactionNumber];
        return (currentOrder.price, currentOrder.duration, currentOrder.licensePlateHash);
    }
}