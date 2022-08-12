// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc20/extensions/ERC20Approve.sol";

/**
 *
 */
contract ERC20ApproveMock is ERC20Approve {
    /**
     *
     */
    constructor(address to, uint256 amount) {
        _totalSupply += amount;
        _balances[to] += amount;
    }
}
