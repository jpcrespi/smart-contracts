/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../extensions/ERC1155Metadata.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 * Inspired by the ERC721URIStorage extension
 *
 * _Available since v4.6._
 */
abstract contract ERC1155MetadataOwned is Ownable, ERC1155Metadata {
    /**
     *
     */
    function setBaseURI(string memory baseURI_) internal virtual onlyOwner {
        _setBaseURI(baseURI_);
    }
}
