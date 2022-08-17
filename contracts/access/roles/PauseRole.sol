/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./AdminRole.sol";

/**
 *
 */
contract PauseRole is AdminRole {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Grants `PAUSER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(PAUSER_ROLE, _msgSender());
    }
}
