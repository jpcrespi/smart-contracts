// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc20/ERC20.sol";

/**
 *
 */
contract ERC20Mock is ERC20 {
    /**
     *
     */
    constructor(address to, uint256 amount) {
        _totalSupply += amount;
        _balances[to] += amount;
    }
}
