// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc20/extensions/ERC20Pausable.sol";

/**
 *
 */
contract ERC20PausableMock is ERC20Pausable {
    /**
     *
     */
    constructor(
        address controller_,
        address to_,
        uint256 amount_
    ) Controllable(controller_) {
        _totalSupply += amount_;
        _balances[to_] += amount_;
    }
}
