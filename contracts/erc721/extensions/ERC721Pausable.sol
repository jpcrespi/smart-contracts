/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/roles/PauseRole.sol";
import "../../security/Controllable.sol";
import "../ERC721.sol";

/**
 * @dev ERC721 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 */
abstract contract ERC721Pausable is ERC721, Controllable, PauseRole, Pausable {
    /**
     * @dev Pauses all token transfers.
     *
     * See {ERC721Pausable} and {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function pause() public virtual {
        require(
            IAccessControl(_controller).hasRole(PAUSER_ROLE, _msgSender()),
            "ERC721Pausable: sender does not have role"
        );
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     *
     * See {ERC721Pausable} and {Pausable-_unpause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function unpause() public virtual {
        require(
            IAccessControl(_controller).hasRole(PAUSER_ROLE, _msgSender()),
            "ERC721Pausable: sender does not have role"
        );
        _unpause();
    }

    /**
     * @dev See {ERC721-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - the contract must not be paused.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        string memory tokenURI
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, tokenId, tokenURI);
        require(
            paused() == false,
            "ERC721Pausable: token transfer while paused"
        );
    }
}
