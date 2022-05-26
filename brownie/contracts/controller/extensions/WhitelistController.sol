// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

// import "../TokenController.sol";
// import "../../security/Whitelistable.sol";

// contract WhitelistController is TokenController, Whitelistable {
//     bytes32 public constant WHITELISTER_ROLE = keccak256("WHITELISTER_ROLE");

//     /**
//      * @dev Grants `WHITELISTER_ROLE` to the account that deploys the contract.
//      */
//     constructor() {
//         _grantRole(WHITELISTER_ROLE, _msgSender());
//     }

//     /**
//      * @dev Pauses all token transfers.
//      *
//      * See {ERC20Whitelistable} and {Whitelistable-_addBlacklisted}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the `PAUSER_ROLE`.
//      */
//     function addBlacklisted(address account)
//         public
//         virtual
//         onlyRole(WHITELISTER_ROLE)
//     {
//         _addBlacklisted(account);
//     }

//     /**
//      * @dev Unpauses all token transfers.
//      *
//      * See {ERC20Whitelistable} and {Whitelistable-_removeBlacklisted}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the `PAUSER_ROLE`.
//      */
//     function removeBlacklisted(address account)
//         public
//         virtual
//         onlyRole(WHITELISTER_ROLE)
//     {
//         _removeBlacklisted(account);
//     }
// }
