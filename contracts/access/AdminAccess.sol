/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../../interfaces/access/IAdminAccess.sol";

/**
 *
 */
contract AdminAccess is AccessControlEnumerable, IAdminAccess {
    /**
     * @dev Grants `DEFAULT_ADMIN_ROLE` to the account that
     * deploys the contract.
     */
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /**
     *
     */
    function isAdmin(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }
}
