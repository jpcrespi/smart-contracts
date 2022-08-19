/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/roles/MintRole.sol";
import "../../access/Controllable.sol";
import "../ERC721.sol";

/**
 * @title ERC721 Mintable Token
 * @dev ERC721 Token that can be mint (created).
 */
abstract contract ERC721Mintable is ERC721, Controllable, MintRole {
    using Counters for Counters.Counter;

    //
    Counters.Counter private _tokenIdTracker;

    /**
     * @dev Creates a new token for `to`. Its token ID will be automatically
     * assigned (and available on the emitted {IERC721-Transfer} event), and the token
     * URI autogenerated based on the base URI passed at construction.
     *
     * See {ERC721-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(address to, string memory tokenURI) public virtual {
        require(
            IAccessControl(_controller).hasRole(MINTER_ROLE, _msgSender()),
            "ERC721Mintable: sender does not have role"
        );
        _mint(to, tokenURI, "", false);
    }

    /**
     * @dev Safely mints `tokenId` and transfers it to `to`.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     *
     * Emits a {Transfer} event.
     */
    function safeMint(address to, string memory tokenURI) public virtual {
        require(
            IAccessControl(_controller).hasRole(MINTER_ROLE, _msgSender()),
            "ERC721Mintable: sender does not have role"
        );
        _mint(to, tokenURI, "", true);
    }

    /**
     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`],
     * with an additional `data` parameter which is
     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.
     */
    function safeMint(
        address to,
        string memory tokenURI,
        bytes memory data
    ) public virtual {
        require(
            IAccessControl(_controller).hasRole(MINTER_ROLE, _msgSender()),
            "ERC721Mintable: sender does not have role"
        );
        _mint(to, tokenURI, data, true);
    }

    /**
     * @dev Mints `tokenId` and transfers it to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - `to` cannot be the zero address.
     *
     * Emits a {Transfer} event.
     */
    function _mint(
        address to,
        string memory tokenURI,
        bytes memory data,
        bool requireReceptionAck
    ) internal virtual {
        // We cannot just use balanceOf to create the new tokenId because tokens
        // can be burned (destroyed), so we need a separate counter
        uint256 tokenId = _tokenIdTracker.current();

        require(
            to != address(0),
            "ERC721Mintable: mint cannot be to the zero address"
        );
        require(
            _exists(tokenId) == false,
            "ERC721Mintable: token already minted"
        );

        _beforeTokenTransfer(address(0), to, tokenId, tokenURI);

        _balances[to] += 1;
        _owners[tokenId] = to;

        if (requireReceptionAck) {
            _doCheckOnERC721Received(address(0), to, tokenId, data);
        }

        _tokenIdTracker.increment();

        emit Transfer(address(0), to, tokenId);

        _afterTokenTransfer(address(0), to, tokenId, tokenURI);
    }
}
