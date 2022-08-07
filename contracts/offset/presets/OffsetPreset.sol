// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../Offset.sol";
import "../../erc20/ERC20Metadata.sol";
import "../extensions/OffsetMintable.sol";

contract OffsetPreset is ERC20Metadata, OffsetMintable {
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) ERC20Metadata(name_, symbol_, decimals_) {}
}
