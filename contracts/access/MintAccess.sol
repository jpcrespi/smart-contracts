/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../interfaces/access/IMintAccess.sol";
import "./roles/MintRole.sol";

/**
 *
 */
contract MintAccess is MintRole, IMintAccess {
    /**
     *
     */
    function isMinter(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(MINTER_ROLE, account);
    }
}
