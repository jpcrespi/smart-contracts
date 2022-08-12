/// SPDX-License-Identifier: MIT
/// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC777.sol";
import "../ERC777Metadata.sol";
import "../extensions/ERC777Mintable.sol";
import "../extensions/ERC777Burnable.sol";
import "../extensions/ERC777Pausable.sol";
import "../extensions/ERC777Operable.sol";

/**
 *
 */
contract ERC777Preset is
    ERC777,
    ERC777Metadata,
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
        ERC777Accesable(controller_)
        ERC777Operable(defaultOperators_)
        ERC777Metadata(name_, symbol_, granularity_)
    {}

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
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC777, ERC777Pausable) {
        super._beforeTokenTransfer(operator, from, to, amount);
    }
}
