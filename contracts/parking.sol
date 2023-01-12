// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./ownable.sol";
import "./safemath.sol";
import "./ordersdata.sol";

contract Parking is Ownable, OrdersData {
    using SafeMath for uint256;
    OrdersData.Order[] public orders;
    mapping (uint => OrdersData.Order) public transactionNumberToOrder;
    mapping (bytes32 => uint) public endDate;

    function getOrderComparePrice(uint transactionNumber, uint price) external onlyOwner returns (uint) {
        OdersData.Order storage currentOrder = orders[orderId];
        return currentOrder.price;
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

    function verifyLicensePlate(bytes32 licensePlateHash) external view returns(bool) {
        return block.timestamp < endDate[licensePlateHash];
    }
}