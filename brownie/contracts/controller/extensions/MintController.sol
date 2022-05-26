// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

// import "../TokenController.sol";

// contract MintController is TokenController {
//     bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

//     /**
//      * @dev Grants `MINTER_ROLE` to the account that deploys the contract.
//      */
//     constructor() {
//         _grantRole(MINTER_ROLE, _msgSender());
//     }

//     /**
//      * @dev See {ERC20-_mint}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the {MinterRole}.
//      */
//     function mint(address to, uint256 amount)
//         public
//         virtual
//         onlyRole(MINTER_ROLE)
//         returns (bool)
//     {
//         address minter = _msgSender();
//         _token.mint(minter, to, amount);
//         return true;
//     }
// }
