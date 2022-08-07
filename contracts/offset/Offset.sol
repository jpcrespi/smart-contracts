// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../access/Controllable.sol";

contract Offset is Controllable {
    uint256 internal _totalSupply;
    mapping(address => uint256) internal _balances;
}
