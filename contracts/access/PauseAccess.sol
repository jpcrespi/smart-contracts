/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../interfaces/access/IPauseAccess.sol";
import "./roles/PauseRole.sol";

/**
 *
 */
contract PauseAccess is PauseRole, IPauseAccess {
    /**
     *
     */
    function isPauser(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(PAUSER_ROLE, account);
    }
}
