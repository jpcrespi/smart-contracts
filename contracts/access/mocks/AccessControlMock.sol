// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/mocks/OwnableMock.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 *
 */
contract AccessControlMock is AccessControl {
    /**
     *
     */
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /**
     *
     */
    function setRoleAdmin(bytes32 roleId, bytes32 adminRoleId) public {
        _setRoleAdmin(roleId, adminRoleId);
    }

    /**
     *
     */
    function senderProtected(bytes32 roleId) public onlyRole(roleId) {}
}
