/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Accesable.sol";

/**
 *
 */
abstract contract AdapterAccess is Accesable {
    bytes32 public constant ADAPTER_ROLE = keccak256("ADAPTER_ROLE");

    /**
     * @dev Grants `ADAPTER_ROLE` to the account that
     * deploys the contract.
     */
    constructor() {
        _grantRole(ADAPTER_ROLE, getAdmin(0));
    }

    /**
     *
     */
    function isAdapter(address account) public view returns (bool) {
        return hasRole(ADAPTER_ROLE, account);
    }
}

contract AdapterAccessMock is AdapterAccess {
    constructor(address account) Accesable(account) {}
}
