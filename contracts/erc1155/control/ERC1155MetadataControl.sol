/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../extensions/ERC1155Metadata.sol";
import "../../access/EditAccess.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 * Inspired by the ERC721URIStorage extension
 *
 * _Available since v4.6._
 */
abstract contract ERC1155MetadataControl is EditAccess, ERC1155Metadata {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, ERC1155)
        returns (bool success)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     *
     */
    function setBaseURI(string memory baseURI_) internal virtual {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setBaseURI(baseURI_);
    }
}
