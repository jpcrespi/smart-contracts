/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../interfaces/access/IBurnAccess.sol";
import "./roles/BurnRole.sol";

/**
 *
 */
contract BurnAccess is BurnRole, IBurnAccess {
    /**
     *
     */
    function isBurner(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(BURNER_ROLE, account);
    }
}
