/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./AdminAccess.sol";
import "../../interfaces/access/IBurnAccess.sol";

/**
 *
 */
contract BurnAccess is AdminAccess, IBurnAccess {
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /**
     * @dev Grants `BURNER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(BURNER_ROLE, _msgSender());
    }

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
