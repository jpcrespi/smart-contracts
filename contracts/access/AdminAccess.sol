/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../interfaces/access/IAdminAccess.sol";
import "./roles/AdminRole.sol";

/**
 *
 */
contract AdminAccess is AdminRole, IAdminAccess {
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
