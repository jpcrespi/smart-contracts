/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/Controllable.sol";
import "../../access/roles/PauseRole.sol";
import "../extensions/ERC1155Pausable.sol";

/**
 * @dev ERC1155 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 *
 * _Available since v3.1._
 */
abstract contract ERC1155PausableAccess is
    Controllable,
    PauseRole,
    ERC1155Pausable
{
    /**
     * @dev Pauses all token transfers.
     *
     * See {ERC1155Pausable} and {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function pause() public virtual {
        require(
            IAccessControl(_controller).hasRole(PAUSER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     *
     * See {ERC1155Pausable} and {Pausable-_unpause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function unpause() public virtual {
        require(
            IAccessControl(_controller).hasRole(PAUSER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _unpause();
    }
}
