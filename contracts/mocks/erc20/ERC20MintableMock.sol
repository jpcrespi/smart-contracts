// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc20/extensions/ERC20Mintable.sol";

/**
 *
 */
contract ERC20MintableMock is ERC20Mintable {
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
