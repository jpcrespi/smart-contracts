/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

/**
 *
 */
contract Accesable is AccessControlEnumerable {
    /**
     * @dev Grants `DEFAULT_ADMIN_ROLE` to the account that
     * deploys the contract.
     */
    constructor(address account) {
        _grantRole(DEFAULT_ADMIN_ROLE, account);
    }

    /**
     *
     */
    function isAdmin(address account) public view returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    /**
     *
     */
    function getAdmin(uint256 index) public view returns (address) {
        return getRoleMember(DEFAULT_ADMIN_ROLE, index);
    }
}
