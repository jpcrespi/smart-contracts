// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
contract Whitelistable is Context, AccessControlEnumerable {
    bytes32 public constant BLACKLIST_ROLE = keccak256("BLACKLIST_ROLE");
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event BlacklistedAdded(address sender, address indexed account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event BlacklistedRemoved(address sender, address indexed account);

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function isWhitelisted(address account) public view returns (bool) {
        return hasRole(BLACKLIST_ROLE, account) == false;
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _addBlacklisted(address account) internal virtual {
        grantRole(BLACKLIST_ROLE, account);
        emit BlacklistedAdded(_msgSender(), account);
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _removeBlacklisted(address account) internal virtual {
        revokeRole(BLACKLIST_ROLE, account);
        emit BlacklistedRemoved(_msgSender(), account);
    }
}
