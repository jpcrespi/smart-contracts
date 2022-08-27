/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../../../interfaces/erc1155/IERC1155.sol";
import "../../../interfaces/erc1155/IERC1155TokenReceiver.sol";

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/roles/EditRole.sol";
import "../../access/Controllable.sol";
import "../holder/ERC1155Holder.sol";

/**
 *
 */
abstract contract ERC1155HolderAccess is Controllable, EditRole, ERC1155Holder {
    /**
     * @dev See {IERC1155-safeTransferFrom}.
     */
    function safeTransferFrom(
        address erc1155,
        address from,
        address to,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) internal virtual {
        require(
            IAccessControl(_controller).hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _safeTransferFrom(erc1155, from, to, id, value, data);
    }

    /**
     * @dev See {IERC1155-safeBatchTransferFrom}.
     */
    function safeBatchTransferFrom(
        address erc1155,
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) internal virtual {
        require(
            IAccessControl(_controller).hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _safeBatchTransferFrom(erc1155, from, to, ids, values, data);
    }

    /**
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function setApprovalForAll(
        address erc1155,
        address operator,
        bool approved
    ) internal virtual {
        require(
            IAccessControl(_controller).hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setApprovalForAll(erc1155, operator, approved);
    }
}
