/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/Accessible.sol";
import "../../access/roles/BurnRole.sol";
import "../../access/roles/MintRole.sol";
import "../../access/roles/PauseRole.sol";

/**
 *
 */
contract ERC721Access is Accessible, BurnRole, MintRole, PauseRole {
    /**
     * @dev Grants roles to the account that
     * deploys the contract.
     */
    constructor() {
        _grantRole(BURNER_ROLE, _msgSender());
        _grantRole(MINTER_ROLE, _msgSender());
        _grantRole(PAUSER_ROLE, _msgSender());
    }
}
