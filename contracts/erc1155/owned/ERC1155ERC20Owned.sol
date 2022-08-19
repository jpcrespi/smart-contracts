/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../extensions/ERC1155ERC20.sol";

/**
 *
 */
abstract contract ERC1155ERC20Owned is Ownable, ERC1155ERC20 {
    /**
     *
     */
    function setERC20Adapter(uint256 tokenId, address tokenAdapter)
        public
        virtual
        onlyOwner
    {
        _setERC20Adapter(tokenId, tokenAdapter);
    }
}
