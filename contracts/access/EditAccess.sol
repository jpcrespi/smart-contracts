/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./AdminAccess.sol";
import "../../interfaces/access/IEditAccess.sol";

/**
 *
 */
contract EditAccess is AdminAccess, IEditAccess {
    bytes32 public constant EDITOR_ROLE = keccak256("EDITOR_ROLE");

    /**
     * @dev Grants `EDITOR_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(EDITOR_ROLE, _msgSender());
    }

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
