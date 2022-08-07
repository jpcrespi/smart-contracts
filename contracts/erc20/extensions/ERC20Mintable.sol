// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./ERC20Accesable.sol";

/**
 * @dev Extension of {ERC20} that adds a set of accounts with the {MinterRole},
 * which have permission to mint (create) new tokens as they see fit.
 *
 * At construction, the deployer of the contract is the only minter.
 */
contract ERC20Mintable is ERC20Accesable {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Mint(address minter, address indexed to, uint256 value);

    /**
     * @dev See {ERC20-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the {MinterRole}.
     */
    function mint(address to, uint256 amount) public virtual returns (bool) {
        require(
            MintAccess(_controller).isMinter(_msgSender()),
            "ERC20Mintable: sender does not have role"
        );
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

        _beforeTokenTransfer(address(0), to, amount);

        _totalSupply += amount;
        _balances[to] += amount;

        emit Mint(_msgSender(), to, amount);
        emit Transfer(address(0), to, amount);

        _afterTokenTransfer(address(0), to, amount);
    }
}

contract ERC20MintableMock is ERC20Mintable {
    constructor(address to, uint256 amount) {
        _totalSupply += amount;
        _balances[to] += amount;
    }
}
