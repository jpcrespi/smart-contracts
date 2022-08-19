/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accessible.sol";
import "../roles/BurnRole.sol";

/**
 *
 */
contract BurnAccess is Accessible, BurnRole {
    /**
     * @dev Grants `BURNER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(BURNER_ROLE, _msgSender());
    }
}
