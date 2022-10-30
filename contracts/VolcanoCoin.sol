// SPDX-License-Identifier: UNLICENSED.

pragma solidity ^0.8.0;

contract VolcanoCoin {

    uint supply = 10000;
    address owner;
    
    event SupplyUpdate(uint);
    event transferUpdate(address,uint);

    mapping(address => uint) balances;
   
    struct Payment {
        address addr; 
        uint amount;
    }

    mapping(address => Payment) public paymentArray;

    Payment transfer;

    constructor() {
        owner = msg.sender;
        balances[owner] = supply; 
    }

    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    modifier enoughBalance(uint checkAmt) {
        if (balances[msg.sender] >= checkAmt) {
            _;
        }
    }

    function getSupply() public view returns (uint) {
        return supply;
    }

    function addSupply() public onlyOwner {
        supply += 1000;
        balances[owner] += 1000;
        emit SupplyUpdate(supply);
    } 

    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }

    function transferCoin(address receipient, uint transferAmount) public enoughBalance(transferAmount) {
        balances[receipient] += transferAmount;
        balances[msg.sender] -= transferAmount;
        emit transferUpdate(receipient, transferAmount);
        transfer.addr = receipient;
        transfer.amount = transferAmount;
    }
}