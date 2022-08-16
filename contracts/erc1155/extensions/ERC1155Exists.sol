/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155Exists.sol";
import "./ERC1155Supply.sol";

/**
 * @dev ERC1155Exists
 */
abstract contract ERC1155Exists is ERC1155Supply, IERC1155Exists {
    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 id) public view virtual override returns (bool) {
        return totalSupply(id) > 0;
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
        //Mint
        if (from != address(0)) {
            for (uint256 i = 0; i < ids.length; ++i) {
                require(
                    exists(ids[i]),
                    "ERC1155: token does not exist (supply == 0)"
                );
            }
        }
    }
}
