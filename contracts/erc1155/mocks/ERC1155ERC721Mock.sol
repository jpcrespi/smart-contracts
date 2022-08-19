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
    constructor(address erc721Adapter_, string memory uri_)
        ERC1155ERC721(erc721Adapter_)
        ERC1155Metadata(uri_)
    {}
}
