// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc721/extensions/ERC721Pausable.sol";

/**
 *
 */
contract ERC721PausableMock is ERC721Pausable {
    /**
     *
     */
    constructor(address controller_) ERC721Accesable(controller_) {}
}
