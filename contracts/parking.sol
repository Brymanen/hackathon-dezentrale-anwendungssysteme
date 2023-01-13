// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./ownable.sol";
import "./safemath.sol";
import "./ordersdata.sol";

contract Parking is Ownable, OrdersData {
    Order[] public orders;
    using SafeMath for uint256;
    mapping (bytes32 => uint) public endDate;
    mapping (uint => Order) public transactionNumberToOrder;
    uint transactionNumber = 0;

    function hardCode() public {
        bytes32 hardcodedLicensePlateHash = keccak256(abi.encodePacked("KL8136"));
        endDate[hardcodedLicensePlateHash] = block.timestamp.add(1000000);
    }

    function placeOrder(uint price, uint duration, string memory licensePlate) external onlyOwner returns(uint) {
        bytes32 licensePlateHash = keccak256(abi.encodePacked(licensePlate));
        transactionNumber = transactionNumber.add(1);
        orders.push(Order(price, duration, licensePlateHash));
        uint orderId = orders.length.sub(1);
        Order storage newOrder = orders[orderId];
        transactionNumberToOrder[transactionNumber] = newOrder;
        return transactionNumber;
    }

    function comparePrice(uint transactionNumber, uint price) external view onlyOwner returns (bool) {
        Order memory currentOrder;
        currentOrder = transactionNumberToOrder[transactionNumber];
        return currentOrder.price == price;
    }

    function saveLicensePlate(string memory licensePlate, uint duration) external onlyOwner {
        bytes32 licensePlateHash = keccak256(abi.encodePacked(licensePlate));
        if (endDate[licensePlateHash] > 0) {
            updateDuration(licensePlateHash, duration);
        } else {
            endDate[licensePlateHash] = block.timestamp.add(duration);
        }
    }

    function updateDuration(bytes32 licensePlateHash, uint duration) internal {
        if (block.timestamp > endDate[licensePlateHash]) {
            endDate[licensePlateHash] = block.timestamp.add(duration);
        } else {
            endDate[licensePlateHash] = endDate[licensePlateHash].add(duration);
        }
    }

    function verifyLicensePlate(string memory licensePlate) external view returns(bool) {
        bytes32 licensePlateHash = keccak256(abi.encodePacked(licensePlate));
        return block.timestamp < endDate[licensePlateHash];
    }
}