const connectContract = async () => {
    const licensePlateABI = [
{
"anonymous": false,
"inputs": [
{
"indexed": true,
"internalType": "address",
"name": "previousOwner",
"type": "address"
},
{
"indexed": true,
"internalType": "address",
"name": "newOwner",
"type": "address"
}
],
"name": "OwnershipTransferred",
"type": "event"
},
{
"inputs": [],
"name": "renounceOwnership",
"outputs": [],
"stateMutability": "nonpayable",
"type": "function"
},
{
"inputs": [
{
"internalType": "string",
"name": "licensePlate",
"type": "string"
},
{
"internalType": "uint256",
"name": "duration",
"type": "uint256"
}
],
"name": "saveLicensePlate",
"outputs": [],
"stateMutability": "nonpayable",
"type": "function"
},
{
"inputs": [
{
"internalType": "address",
"name": "newOwner",
"type": "address"
}
],
"name": "transferOwnership",
"outputs": [],
"stateMutability": "nonpayable",
"type": "function"
},
{
"inputs": [
{
"internalType": "string",
"name": "",
"type": "string"
}
],
"name": "endDate",
"outputs": [
{
"internalType": "uint256",
"name": "",
"type": "uint256"
}
],
"stateMutability": "view",
"type": "function"
},
{
"inputs": [],
"name": "owner",
"outputs": [
{
"internalType": "address",
"name": "",
"type": "address"
}
],
"stateMutability": "view",
"type": "function"
},
{
"inputs": [
{
"internalType": "string",
"name": "licensePlate",
"type": "string"
}
],
"name": "verifyLicensePlate",
"outputs": [
{
"internalType": "bool",
"name": "",
"type": "bool"
}
],
"stateMutability": "view",
"type": "function"
}
];
    const licensePlateAddress = "0x40cD9f2D4E8bDeE70377d43DED2cc5055d10b605";
    window.web3 = await new Web3(window.ethereum);
    window.contract = await new window.web3.eth.Contract( licensePlateABI, licensePlateAddress);
    document.getElementById("contractArea").innerHTML = "connected to smart contract";
}
