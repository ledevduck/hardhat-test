// Simple storage contract inspired by Patrick Collins tutorial on freecodecamp youtube channel

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract SimpleStorage {
    uint public num;

    struct People {
        uint num;
        address sender;
    }

    People[] public people;

    mapping (address => uint) addressToNum;

    constructor(uint _num) {
        num = _num;
        people.push(People(_num, msg.sender));
        addressToNum[msg.sender] = _num;
    }

    function setNum(uint _num) public {
        num = _num;
        people.push(People(_num, msg.sender));
        addressToNum[msg.sender] = _num;
    }

    function retrieve() public view returns (uint) {
        return num;
    }
}
