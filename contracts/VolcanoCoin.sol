// SPDX-License-Identifier: UNLICENSED.

pragma solidity ^0.8.0;

contract VolcanoCoin {

    uint supply = 10000;
    address owner;
    
    event SupplyUpdate(uint);
    event transferUpdate(address,uint);
    event seeArray(Payment[]);
  
    mapping(address => uint) balances;
   
    struct Payment {
        address addr; 
        uint amount;
    }

    Payment[] public Payments;

    mapping(address => Payment[]) public paymentArray;

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
        //Payments[Payments.length+1] = Payment(receipient,transferAmount);
        paymentArray[msg.sender].push(Payment(receipient,transferAmount));
    }
}