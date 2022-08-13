/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./AdminAccess.sol";
import "../../interfaces/access/IAdaptAccess.sol";

/**
 *
 */
contract AdaptAccess is AdminAccess, IAdaptAccess {
    bytes32 public constant ADAPTER_ROLE = keccak256("ADAPTER_ROLE");

    /**
     * @dev Grants `ADAPTER_ROLE` to the account that deploys the contract.
     */
    constructor() {
        _grantRole(ADAPTER_ROLE, _msgSender());
    }

    /**
     *
     */
    function isAdapter(address account)
        public
        view
        virtual
        override
        returns (bool)
    {
        return hasRole(ADAPTER_ROLE, account);
    }
}
