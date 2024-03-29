/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/Accessible.sol";
import "../../access/roles/BurnRole.sol";
import "../../access/roles/MintRole.sol";
import "../../access/roles/PauseRole.sol";
import "../../access/roles/EditRole.sol";
import "../../access/roles/HoldRole.sol";

/**
 *
 */
contract ERC1155Access is
    Accessible,
    BurnRole,
    MintRole,
    PauseRole,
    EditRole,
    HoldRole
{
    /**
     * @dev Grants roles to the account that
     * deploys the contract.
     */
    constructor() {
        _grantRole(BURNER_ROLE, _msgSender());
        _grantRole(MINTER_ROLE, _msgSender());
        _grantRole(PAUSER_ROLE, _msgSender());
        _grantRole(EDITOR_ROLE, _msgSender());
        _grantRole(HOLDER_ROLE, _msgSender());
    }
}
