// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

// import "../extensions/BurnController.sol";
// import "../extensions/MintController.sol";
// import "../extensions/OffsetController.sol";
// import "../extensions/PauseController.sol";
// import "../extensions/WhitelistController.sol";

// contract ControllerPreset is
//     BurnController,
//     MintController,
//     OffsetController,
//     PauseController,
//     WhitelistController,
//     IWRC425
// {
//     function allowTokenTransfer(address from, address to)
//         external
//         view
//         override
//         returns (bool success)
//     {
//         require(isWhitelisted(from), "Whitelist: from account is blacklisted");
//         require(isWhitelisted(to), "Whitelist: to account is blacklisted");
//         require(paused() == false, "Pause: token transfer while paused");
//         return true;
//     }
// }
