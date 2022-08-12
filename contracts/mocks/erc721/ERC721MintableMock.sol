// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc721/extensions/ERC721Mintable.sol";

/**
 *
 */
contract ERC721MintableMock is ERC721Mintable {
    /**
     *
     */
    constructor(address controller_) ERC721Accesable(controller_) {}
}
