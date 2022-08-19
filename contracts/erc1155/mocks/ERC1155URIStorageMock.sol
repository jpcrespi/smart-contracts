/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../extensions/ERC1155URIStorage.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 * Inspired by the ERC721URIStorage extension
 *
 * _Available since v4.6._
 */
abstract contract ERC1155URIStorageMock is ERC1155URIStorage {
    /**
     *
     */
    function setURI(uint256 tokenId, string memory tokenURI) internal virtual {
        _setURI(tokenId, tokenURI);
    }
}
