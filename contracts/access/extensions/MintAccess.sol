/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accessible.sol";
import "../roles/MintRole.sol";

/**
 *
 */
contract MintAccess is Accessible, MintRole {
    /**
     * @dev Grants `MINTER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(MINTER_ROLE, _msgSender());
    }
}
