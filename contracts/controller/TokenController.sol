// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
// import "../erc20/presets/ERC20Preset.sol";
// import "../offset/presets/OffsetPreset.sol";

// contract TokenController is Ownable, AccessControlEnumerable {
//     ERC20Preset internal _token;
//     OffsetPreset internal _offset;

//     constructor() {
//         _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
//         _token = new ERC20Preset("Nativas", "CO2", 0);
//         _offset = new OffsetPreset("Offset", "OCF", 0);
//     }

//     function token() public view returns (address) {
//         return address(_token);
//     }

//     function offset() public view returns (address) {
//         return address(_offset);
//     }
// }
