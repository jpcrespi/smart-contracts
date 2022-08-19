/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accessable.sol";
import "../roles/PauseRole.sol";

/**
 *
 */
contract PauseAccess is Accessable, PauseRole {
    /**
     * @dev Grants `PAUSER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(PAUSER_ROLE, _msgSender());
    }
}
