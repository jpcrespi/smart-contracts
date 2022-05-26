// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Offset.sol";

/**
 * @dev Extension of {ERC20} that adds a set of accounts with the {MinterRole},
 * which have permission to mint (create) new tokens as they see fit.
 *
 * At construction, the deployer of the contract is the only minter.
 */
contract OffsetMintable is Offset {
    event Mint(address minter, address indexed to, uint256 value);

    /**
     * @dev See {ERC20-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the controller.
     */
    function mint(address to, uint256 amount)
        public
        onlyController
        returns (bool)
    {
        _mint(to, amount);
        return true;
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address to, uint256 amount) internal virtual {
        require(to != address(0), "ERC20Mintable: mint to the zero address");

        _totalSupply += amount;
        _balances[to] += amount;

        emit Mint(_msgSender(), to, amount);
    }
}
