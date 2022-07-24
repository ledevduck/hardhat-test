// Simple ether wallet inspired by solidity-by-example.org ether-wallet
// anyone can send eth
// only contract owner can withdraw

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract EtherWallet {
    event Deposit(address indexed sender, uint amount, uint balance);
    event Withdraw(address indexed recipient, uint amount, uint balance);
    event Response(bool success, bytes data);

    address public owner;
    uint public balance;

    mapping (address => uint) public addressToDepositAmount;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        balance += msg.value;
        addressToDepositAmount[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value, balance);
    }

    function getBalance() external view returns (uint) {
        // return contract balance
        return address(this).balance;
        // return eth deposit via receive function only (not by contract destruction)
        // return balance;
    }

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "Not the owner");
        require(_amount <= address(this).balance, "Not enough ETH available in contract");

        balance -= _amount;

        (bool sent, bytes memory data) = owner.call{value: _amount}("");
        require(sent, "Failed to send Ether");

        emit Response(sent, data);
    }
}
