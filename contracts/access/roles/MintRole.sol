/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./AdminRole.sol";

/**
 *
 */
contract MintRole is AdminRole {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /**
     * @dev Grants `MINTER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(MINTER_ROLE, _msgSender());
    }
}