/// SPDX-License-Identifier: MIT
/// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../backward/ERC777ERC20.sol";
import "../backward/ERC777ERC20Metadata.sol";
import "../backward/ERC777ERC20Approve.sol";
import "../extensions/ERC777Mintable.sol";
import "../extensions/ERC777Burnable.sol";
import "../extensions/ERC777Pausable.sol";
import "../extensions/ERC777Operable.sol";

/**
 *
 */
contract ERC777ERC20Preset is
    ERC777ERC20,
    ERC777ERC20Metadata,
    ERC777ERC20Approve,
    ERC777Mintable,
    ERC777Burnable,
    ERC777Pausable,
    ERC777Operable
{
    /**
     *
     */
    constructor(
        address controller_,
        address[] memory defaultOperators_,
        string memory name_,
        string memory symbol_,
        uint256 granularity_
    )
        Controllable(controller_)
        ERC777Operable(defaultOperators_)
        ERC777ERC20Metadata(name_, symbol_, granularity_)
    {}

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply()
        public
        view
        virtual
        override(ERC777, ERC777ERC20)
        returns (uint256)
    {
        return super.totalSupply();
    }

    /**
     * @dev Returns the amount of tokens owned by an account (`account`).
     */
    function balanceOf(address account)
        public
        view
        virtual
        override(ERC777, ERC777ERC20)
        returns (uint256)
    {
        return super.balanceOf(account);
    }

    /**
     * @dev See {IERC777-burn}.
     */
    function burn(uint256 amount, bytes memory data)
        public
        virtual
        override(ERC777, ERC777Burnable)
    {
        super.burn(amount, data);
    }

    /**
     * @dev See {IERC777-operatorBurn}.
     */
    function operatorBurn(
        address account,
        uint256 amount,
        bytes memory data,
        bytes memory operatorData
    ) public virtual override(ERC777, ERC777Burnable) {
        super.operatorBurn(account, amount, data, operatorData);
    }

    /**
     *
     */
    function _afterTokenTransfer(
        address operator,
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC777, ERC777ERC20) {
        super._afterTokenTransfer(operator, from, to, amount);
    }

    /**
     *
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC777, ERC777Pausable) {
        super._beforeTokenTransfer(operator, from, to, amount);
    }
}
