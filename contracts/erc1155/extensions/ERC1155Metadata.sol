/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "../../../interfaces/erc1155/IERC1155MetadataURI.sol";
import "../../../interfaces/access/IEditAccess.sol";
import "../ERC1155.sol";
import "../../security/Controllable.sol";

/**
 * @dev ERC1155 token with storage based token URI management.
 * Inspired by the ERC721URIStorage extension
 *
 * _Available since v4.6._
 */
abstract contract ERC1155Metadata is
    ERC1155,
    Controllable,
    IERC1155MetadataURI
{
    using Strings for uint256;

    // Used as the URI for all token types by relying on ID substitution,
    // e.g. https://token-cdn-domain/{id}.json
    string private _uri;

    /**
     * @dev See {_setURI}.
     */
    constructor(string memory uri_) {
        _uri = uri_;
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     */
    function uri(uint256 id)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return string(abi.encodePacked(_uri, id.toString()));
    }

    /**
     *
     */
    function setBaseURI(string memory uri_) internal virtual {
        require(
            IEditAccess(_controller).isEditor(_msgSender()),
            "ERC1155: sender does not have role"
        );
        _setBaseURI(uri_);
    }

    /**
     * @dev Sets `baseURI` as the `_baseURI` for all tokens
     */
    function _setBaseURI(string memory uri_) internal virtual {
        _uri = uri_;
    }
}
