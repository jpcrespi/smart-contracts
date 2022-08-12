// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc1155/extensions/ERC1155ERC20.sol";

/**
 *
 */
contract ERC1155ERC20Mock is ERC1155ERC20 {
    /**
     *
     */
    constructor(address controller_) ERC1155Accesable(controller_) {}
}
