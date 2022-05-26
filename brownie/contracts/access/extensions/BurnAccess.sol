/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accesable.sol";

/**
 *
 */
abstract contract BurnAccess is Accesable {
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /**
     * @dev Grants `BURNER_ROLE` to the account that
     * deploys the contract.
     */
    constructor() {
        _grantRole(BURNER_ROLE, getAdmin(0));
    }

    /**
     *
     */
    function isBurner(address account) public view returns (bool) {
        return hasRole(BURNER_ROLE, account);
    }
}

contract BurnAccessMock is BurnAccess {
    constructor(address account) Accesable(account) {}
}
