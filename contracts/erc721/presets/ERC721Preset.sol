/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC721Metadata.sol";
import "../extensions/ERC721Mintable.sol";
import "../extensions/ERC721Burnable.sol";
import "../extensions/ERC721Pausable.sol";
import "../extensions/ERC721Enumerable.sol";
import "../extensions/ERC721URIStorage.sol";

/**
 *
 */
contract ERC721Preset is
    ERC721Mintable,
    ERC721Burnable,
    ERC721Pausable,
    ERC721Enumerable,
    ERC721URIStorage
{
    constructor(
        address controller_,
        string memory name_,
        string memory symbol_,
        string memory baseURI_
    ) Controllable(controller_) ERC721URIStorage(name_, symbol_, baseURI_) {}

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC721Metadata, ERC721Enumerable)
        returns (bool success)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     *
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        string memory tokenURI
    )
        internal
        virtual
        override(
            ERC721Common,
            ERC721Pausable,
            ERC721Enumerable,
            ERC721URIStorage
        )
    {
        super._beforeTokenTransfer(from, to, tokenId, tokenURI);
    }
}
