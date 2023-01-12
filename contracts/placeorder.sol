// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./ownable.sol";
import "./safemath.sol";

contract PlaceOrder is Ownable {
    using SafeMath for uint256;
    
    //event NewOrder(uint zombieId, string name, uint dna);

    struct Order {
        uint price;
        uint duration;
        bytes32 licensePlateHash;
    }

    Order[] public orders;

    mapping (uint => Order) public transactionNumberToOrder;

    function placeOrder(uint price, uint duration, string memory licensePlate) external onlyOwner {
        
        bytes32 licensePlateHash = keccak256(abi.encodePacked(licensePlate));
        uint transactionNumber = generateTransactionNumber();
    
        //newOrder = Order(price, duration, licensePlateHash);
        orders.push(Order(price, duration, licensePlateHash));
        uint orderId = orders.length.sub(1);
        Order storage newOrder = orders[orderId];
        transactionNumberToOrder[transactionNumber] = newOrder;

        //uint id = orders.length.sub(1);

        //emit NewOrder(price, duration, licensePlateHash);
    }

    function generateTransactionNumber() internal view returns(uint) {
        //Generates a random number between 0 and 100.
        uint randNonce = 0;
        uint modulus = 100000;
        randNonce == randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % modulus;
    }
}