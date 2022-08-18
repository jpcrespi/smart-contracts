/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../security/Controllable.sol";
import "../../access/roles/EditRole.sol";
import "../extensions/ERC1155URIStorage.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 * Inspired by the ERC721URIStorage extension
 *
 * _Available since v4.6._
 */
abstract contract ERC1155URIStorageAccess is
    Controllable,
    EditRole,
    ERC1155URIStorage
{
    /**
     *
     */
    function setURI(uint256 tokenId, string memory tokenURI) internal virtual {
        require(
            IAccessControl(_controller).hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setURI(tokenId, tokenURI);
    }
}
