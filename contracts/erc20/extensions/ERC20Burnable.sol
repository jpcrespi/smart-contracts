// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/extensions/ERC20Burnable.sol)

pragma solidity ^0.8.0;

import "./ERC20Accesable.sol";

/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
contract ERC20Burnable is ERC20Accesable {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Burn(address burner, address indexed from, uint256 value);

    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public virtual returns (bool) {
        require(
            BurnAccess(_controller).isBurner(_msgSender()),
            "ERC20Burnable: sender does not have role"
        );
        _burn(_msgSender(), amount);
        return true;
    }

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance.
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `amount`.
     */
    function burnFrom(address from, uint256 amount)
        public
        virtual
        returns (bool)
    {
        require(
            BurnAccess(_controller).isBurner(_msgSender()),
            "ERC20Burnable: sender does not have role"
        );
        _spendAllowance(from, _msgSender(), amount);
        _burn(from, amount);
        return true;
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address from, uint256 amount) internal virtual {
        require(
            from != address(0),
            "ERC20Burnable: burn from the zero address"
        );

        _beforeTokenTransfer(from, address(0), amount);

        uint256 accountBalance = _balances[from];
        require(
            accountBalance >= amount,
            "ERC20Burnable: burn amount exceeds balance"
        );
        unchecked {
            _balances[from] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Burn(_msgSender(), from, amount);
        emit Transfer(from, address(0), amount);

        _afterTokenTransfer(from, address(0), amount);
    }
}

contract ERC20BurnableMock is ERC20Burnable {
    constructor(address to, uint256 amount) {
        _totalSupply += amount;
        _balances[to] += amount;
    }
}
