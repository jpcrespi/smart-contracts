// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi 

pragma solidity >=0.6.0 <0.9.0;

import "./Token/Token.sol";

contract Warecoin is Token {

    constructor() {
        _name = "Warecoin";
        _symbol = "WC";
        _decimals = 8;
    }
}