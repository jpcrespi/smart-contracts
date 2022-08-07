// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

// import "../TokenController.sol";

// contract OffsetController is TokenController {
//     /**
//      *
//      */
//     function performOffset(uint256 amount) public returns (bool) {
//         address offseter = _msgSender();
//         _performOffset(offseter, amount);
//         return true;
//     }

//     /**
//      *
//      */
//     function _performOffset(address offseter, uint256 amount) internal virtual {
//         _token.burn(offseter, amount);
//         _offset.mint(offseter, amount);
//     }
// }
