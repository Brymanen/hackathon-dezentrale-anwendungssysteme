// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./ownable.sol";

contract Parking is Ownable {
    mapping (string => uint) public endDate;

    function saveLicensePlate(string memory licensePlate, uint duration) external onlyOwner {
        //string licensePlateHash = keccak256(abi.encodePacked(licensePlate));
        //uint zahl;
        //zahl = 500;
        //return zahl;

        //return endDate[licensePlate];
        if (endDate[licensePlate] > 0) {
            updateDuration(licensePlate, duration);
        } else {
            endDate[licensePlate] = block.timestamp + duration;
        }
    }
    function updateDuration(string memory licensePlate, uint duration) internal {
        if (block.timestamp > endDate[licensePlate]) {
            endDate[licensePlate] = block.timestamp + duration;
        } else {
            endDate[licensePlate] = endDate[licensePlate] + duration;
        }
    }

    function verifyLicensePlate(string memory licensePlate) external view returns(bool) {
        return block.timestamp < endDate[licensePlate];
    }

}