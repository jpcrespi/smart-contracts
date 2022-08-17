// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc1155/extensions/ERC1155ERC20.sol";

/**
 *
 */
contract ERC1155ERC20Mock is ERC1155ERC20 {
    /**
     *
     */
    function setERC20Adapter(uint256 tokenId, address tokenAdapter)
        public
        virtual
    {
        _setERC20Adapter(tokenId, tokenAdapter);
    }
}
