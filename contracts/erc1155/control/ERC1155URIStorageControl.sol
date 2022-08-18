/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/EditAccess.sol";
import "../extensions/ERC1155URIStorage.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 * Inspired by the ERC721URIStorage extension
 *
 * _Available since v4.6._
 */
abstract contract ERC1155URIStorageControl is EditAccess, ERC1155URIStorage {
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
    function setURI(uint256 tokenId, string memory tokenURI) internal virtual {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setURI(tokenId, tokenURI);
    }
}
