/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./ERC1155Burnable.sol";

/**
 * @dev Implementation of the basic standard multi-token.
 * See https://eips.ethereum.org/EIPS/eip-1155
 * Originally based on code by Enjin: https://github.com/enjin/erc-1155
 *
 * _Available since v3.1._
 */
abstract contract ERC1155Offsetable is ERC1155Burnable {
    /**
     *
     */
    function offset(
        address account,
        uint256 id,
        uint256 value
    ) public virtual {
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burn(account, id, value);
    }

    /**
     *
     */
    function offsetBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values
    ) public virtual {
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burnBatch(account, ids, values);
    }
}
