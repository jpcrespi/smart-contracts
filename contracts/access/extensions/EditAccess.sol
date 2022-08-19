/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accessible.sol";
import "../roles/EditRole.sol";

/**
 *
 */
contract EditAccess is Accessible, EditRole {
    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(EDITOR_ROLE, _msgSender());
    }
}
