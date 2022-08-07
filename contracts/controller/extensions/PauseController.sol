// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

// import "../TokenController.sol";
// import "@openzeppelin/contracts/security/Pausable.sol";

// contract PauseController is TokenController, Pausable {
//     bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

//     /**
//      * @dev Grants `PAUSER_ROLE` to the account that deploys the contract.
//      */
//     constructor() {
//         _grantRole(PAUSER_ROLE, _msgSender());
//     }

//     /**
//      * @dev Pauses all token transfers.
//      *
//      * See {ERC20Pausable} and {Pausable-_pause}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the `PAUSER_ROLE`.
//      */
//     function pause() public virtual onlyRole(PAUSER_ROLE) {
//         _pause();
//     }

//     /**
//      * @dev Unpauses all token transfers.
//      *
//      * See {ERC20Pausable} and {Pausable-_unpause}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the `PAUSER_ROLE`.
//      */
//     function unpause() public virtual onlyRole(PAUSER_ROLE) {
//         _unpause();
//     }
// }
