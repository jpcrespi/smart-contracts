// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc1155/extensions/ERC1155ERC721.sol";

/**
 *
 */
contract ERC1155ERC721Mock is ERC1155ERC721 {
    /**
     *
     */
    constructor(
        address controller_,
        string memory name_,
        string memory symbol_,
        string memory uri_
    )
        Controllable(controller_)
        ERC1155Metadata(uri_)
        ERC1155ERC721(name_, symbol_)
    {}
}
