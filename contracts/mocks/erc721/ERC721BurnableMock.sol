// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc721/extensions/ERC721Burnable.sol";

/**
 *
 */
contract ERC721BurnableMock is ERC721Burnable {
    /**
     *
     */
    constructor(address controller_) ERC721Accesable(controller_) {}
}
