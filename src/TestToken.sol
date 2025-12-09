// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TestToken {
    string public constant name = "TestToken";
    string public constant symbol = "TT";
    uint8  public constant decimals = 18;

    mapping(address => uint256) public balanceOf;
    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        uint256 supply = 1_000_000 ether; // 1M tokens
        balanceOf[msg.sender] = supply;
        emit Transfer(address(0), msg.sender, supply);
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        unchecked {
            balanceOf[msg.sender] -= amount;
            balanceOf[to] += amount;
        }
        emit Transfer(msg.sender, to, amount);
        return true;
    }
}
