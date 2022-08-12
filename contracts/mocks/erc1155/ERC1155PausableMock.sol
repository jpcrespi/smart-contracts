// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc1155/extensions/ERC1155Pausable.sol";

/**
 *
 */
contract ERC1155PausableMock is ERC1155Pausable {
    /**
     *
     */
    constructor(address controller_) ERC1155Accesable(controller_) {}
}
