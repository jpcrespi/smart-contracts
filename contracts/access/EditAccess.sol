/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../interfaces/access/IEditAccess.sol";
import "./roles/EditRole.sol";

/**
 *
 */
contract EditAccess is EditRole, IEditAccess {
    /**
     *
     */
    function isEditor(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(EDITOR_ROLE, account);
    }
}
