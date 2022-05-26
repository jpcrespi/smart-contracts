/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accesable.sol";

/**
 *
 */
abstract contract PauseAccess is Accesable {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Grants `PAUSER_ROLE` to the account that
     * deploys the contract.
     */
    constructor() {
        _grantRole(PAUSER_ROLE, getAdmin(0));
    }

    /**
     *
     */
    function isPauser(address account) public view returns (bool) {
        return hasRole(PAUSER_ROLE, account);
    }
}

contract PauseAccessMock is PauseAccess {
    constructor(address account) Accesable(account) {}
}
