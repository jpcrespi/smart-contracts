/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./AdminAccess.sol";
import "../../interfaces/access/IMintAccess.sol";

/**
 *
 */
contract MintAccess is AdminAccess, IMintAccess {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /**
     * @dev Grants `MINTER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(MINTER_ROLE, _msgSender());
    }

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
