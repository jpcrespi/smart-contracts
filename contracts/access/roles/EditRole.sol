/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./AdminRole.sol";

/**
 *
 */
contract EditRole is AdminRole {
    bytes32 public constant EDITOR_ROLE = keccak256("EDITOR_ROLE");

    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(EDITOR_ROLE, _msgSender());
    }
}
