/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc20/presets/ERC20Preset.sol";

/**
 *
 */
contract ERC20PresetMock is ERC20Preset {
    /**
     *
     */
    constructor(
        address controller_,
        address to,
        uint256 amount
    ) ERC20Preset(controller_, "TestCoin", "TST", 0) {
        _totalSupply += amount;
        _balances[to] += amount;
    }
}
