/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accessible.sol";
import "../roles/HoldRole.sol";

/**
 *
 */
contract HoldAccess is Accessible, HoldRole {
    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(HOLDER_ROLE, _msgSender());
    }
}
