/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/access/IEditAccess.sol";
import "../../security/Controllable.sol";
import "../extensions/ERC1155Metadata.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 * Inspired by the ERC721URIStorage extension
 *
 * _Available since v4.6._
 */
abstract contract ERC1155MetadataAccess is Controllable, ERC1155Metadata {
    /**
     *
     */
    function setBaseURI(string memory baseURI_) internal virtual {
        require(
            IEditAccess(_controller).isEditor(_msgSender()),
            "ERC1155: sender does not have role"
        );
        _setBaseURI(baseURI_);
    }
}
