/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155ERC721.sol";
import "./ERC1155Accesable.sol";
import "./ERC1155Ownable.sol";
import "./ERC1155URIStorage.sol";
import {ERC721Adapter} from "../adapters/ERC721Adapter.sol";

contract ERC1155ERC721 is
    ERC1155Accesable,
    ERC1155Ownable,
    ERC1155URIStorage,
    IERC1155ERC721
{
    //
    address internal _erc721;

    /**
     *
     */
    constructor(
        string memory name_,
        string memory symbol_,
        string memory uri_
    ) ERC1155URIStorage(uri_) {
        _erc721 = address(new ERC721Adapter(name_, symbol_));
    }

    /**
     *
     */
    function erc721Adapter() public view returns (address) {
        return _erc721;
    }

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
    ) public override {
        require(
            _msgSender() == erc721Adapter(),
            "ERC1155: caller is not the token adapter"
        );
        _transferFrom(operator, from, to, id, amount, data);
    }

    /**
     *
     */
    function erc721SetApprovalForAll(
        address owner,
        address operator,
        bool approved
    ) public override {
        require(
            _msgSender() == erc721Adapter(),
            "ERC1155: caller is not the token adapter"
        );
        _setApprovalForAll(owner, operator, approved);
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(ERC1155, ERC1155Ownable) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
