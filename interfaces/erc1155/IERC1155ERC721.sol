/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./IERC1155.sol";
import "./IERC1155Supply.sol";
import "./IERC1155Ownable.sol";
import "./IERC1155MetadataURI.sol";

interface IERC1155ERC721 is IERC1155Ownable, IERC1155MetadataURI {
    /**
     *
     */
    function erc721TransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external;

    /**
     *
     */
    function erc721SetApprovalForAll(
        address owner,
        address operator,
        bool approved
    ) external;
}
