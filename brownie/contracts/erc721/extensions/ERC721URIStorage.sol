/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../ERC721Metadata.sol";

/**
 * @dev ERC721 token with storage based token URI management.
 */
contract ERC721URIStorage is ERC721Metadata {
    using Strings for uint256;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /**
     *
     */
    constructor(
        string memory name_,
        string memory symbol_,
        string memory baseURI_
    ) ERC721Metadata(name_, symbol_, baseURI_) {}

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721URIStorage: URI query for nonexistent token"
        );

        string memory _tokenURI = _tokenURIs[tokenId];
        // If there is no base URI, return the token URI.
        if (bytes(_baseURI).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(_baseURI, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning.
     *
     * Calling conditions:
     *
     * - When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
     * transferred to `to`.
     * - When `from` is zero, `tokenId` will be minted for `to`.
     * - When `to` is zero, ``from``'s `tokenId` will be burned.
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        string memory tokenURI_
    ) internal virtual override {
        super._afterTokenTransfer(from, to, tokenId, tokenURI_);
        // Burn
        if (to == address(0)) {
            _removeTokenURI(tokenId);
        }
        // Mint
        if (from == address(0)) {
            _addTokenURI(tokenId, tokenURI_);
        }
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     */
    function _addTokenURI(uint256 tokenId, string memory tokenURI_)
        internal
        virtual
    {
        if (bytes(tokenURI_).length != 0) {
            _tokenURIs[tokenId] = tokenURI_;
        }
    }

    /**
     * @dev Remove `_tokenURI` as the tokenURI of `tokenId`.
     */
    function _removeTokenURI(uint256 tokenId) internal virtual {
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}
