// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

// import "../TokenController.sol";

// contract BurnController is TokenController {
//     bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

//     /**
//      * @dev Grants `BURNER_ROLE` to the account that deploys the contract.
//      */
//     constructor() {
//         _grantRole(BURNER_ROLE, _msgSender());
//     }

//     /**
//      * @dev Destroys `amount` tokens from the caller.
//      *
//      * See {ERC20-_burn}.
//      */
//     function burn(uint256 amount)
//         public
//         virtual
//         onlyRole(BURNER_ROLE)
//         returns (bool)
//     {
//         address burner = _msgSender();
//         _token.burn(burner, amount);
//         return true;
//     }

//     /**
//      * @dev Destroys `amount` tokens from `account`, deducting from the caller's
//      * allowance.
//      *
//      * See {ERC20-_burn} and {ERC20-allowance}.
//      *
//      * Requirements:
//      *
//      * - the caller must have allowance for ``accounts``'s tokens of at least
//      * `amount`.
//      */
//     function burnFrom(address from, uint256 amount)
//         public
//         virtual
//         onlyRole(BURNER_ROLE)
//         returns (bool)
//     {
//         address burner = _msgSender();
//         _token.burnFrom(burner, from, amount);
//         return true;
//     }
// }
