/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accesable.sol";
import "../../../interfaces/access/IPauseAccess.sol";

/**
 *
 */
contract PauseAccess is Accesable, IPauseAccess {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Grants `PAUSER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(PAUSER_ROLE, _msgSender());
    }

    /**
     *
     */
    function isPauser(address account) public view returns (bool) {
        return hasRole(PAUSER_ROLE, account);
    }
}
