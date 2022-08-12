// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC20Metadata.sol";
import "../extensions/BEP20.sol";
import "../extensions/ERC20Approve.sol";
import "../extensions/ERC20Mintable.sol";
import "../extensions/ERC20Burnable.sol";
import "../extensions/ERC20Pausable.sol";

/**
 *
 */
contract ERC20Preset is
    ERC20Metadata,
    ERC20Approve,
    BEP20,
    ERC20Mintable,
    ERC20Burnable,
    ERC20Pausable
{
    /**
     *
     */
    constructor(
        address controller_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) ERC20Accesable(controller_) ERC20Metadata(name_, symbol_, decimals_) {}

    /**
     *
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }
}
