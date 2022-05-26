/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accesable.sol";

/**
 *
 */
abstract contract MintAccess is Accesable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /**
     * @dev Grants `MINTER_ROLE` to the account that
     * deploys the contract.
     */
    constructor() {
        _grantRole(MINTER_ROLE, getAdmin(0));
    }

    /**
     *
     */
    function isMinter(address account) public view returns (bool) {
        return hasRole(MINTER_ROLE, account);
    }
}

contract MintAccessMock is MintAccess {
    constructor(address account) Accesable(account) {}
}
