/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../security/Controllable.sol";
import "../../access/roles/MintRole.sol";
import "../extensions/ERC1155Mintable.sol";

/**
 * @dev Implementation of the basic standard multi-token.
 * See https://eips.ethereum.org/EIPS/eip-1155
 * Originally based on code by Enjin: https://github.com/enjin/erc-1155
 *
 * _Available since v3.1._
 */
abstract contract ERC1155MintableAccess is
    Controllable,
    MintRole,
    ERC1155Mintable
{
    /**
     * @dev Creates `amount` new tokens for `to`, of token type `id`.
     *
     * See {ERC1155-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual {
        require(
            IAccessControl(_controller).hasRole(MINTER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _mint(to, id, amount, data);
    }

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] variant of {mint}.
     */
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual {
        require(
            IAccessControl(_controller).hasRole(MINTER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _mintBatch(to, ids, amounts, data);
    }
}
