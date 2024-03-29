/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/roles/PauseRole.sol";
import "../../access/Controllable.sol";
import "../ERC777.sol";

/**
 * @dev ERC777 token with pausable token transfers, minting and burning.
 *
 * Useful for scenarios such as preventing trades until the end of an evaluation
 * period, or having an emergency switch for freezing all token transfers in the
 * event of a large bug.
 */
abstract contract ERC777Pausable is ERC777, Controllable, PauseRole, Pausable {
    /**
     * @dev Pauses all token transfers.
     *
     * See {ERC20Pausable} and {Pausable-_pause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function pause() public virtual {
        require(
            IAccessControl(_controller).hasRole(PAUSER_ROLE, _msgSender()),
            "ERC777Pausable: sender does not have role"
        );
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     *
     * See {ERC20Pausable} and {Pausable-_unpause}.
     *
     * Requirements:
     *
     * - the caller must have the `PAUSER_ROLE`.
     */
    function unpause() public virtual {
        require(
            IAccessControl(_controller).hasRole(PAUSER_ROLE, _msgSender()),
            "ERC777Pausable: sender does not have role"
        );
        _unpause();
    }

    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - the contract must not be paused.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, amount);
        require(
            paused() == false,
            "ERC777Pausable: token transfer while paused"
        );
    }
}
