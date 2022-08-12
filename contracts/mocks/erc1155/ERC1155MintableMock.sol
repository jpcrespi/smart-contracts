// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc1155/extensions/ERC1155Mintable.sol";

/**
 *
 */
contract ERC1155MintableMock is ERC1155Mintable {
    /**
     *
     */
    constructor(address controller_) ERC1155Accesable(controller_) {}
}
