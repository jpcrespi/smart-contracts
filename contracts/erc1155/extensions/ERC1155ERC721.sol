/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155ERC721.sol";
import "./ERC1155Ownable.sol";
import "./ERC1155Metadata.sol";

/**
 *
 */
abstract contract ERC1155ERC721 is
    ERC1155Metadata,
    ERC1155Ownable,
    IERC1155ERC721
{
    //
    address internal _erc721Adapter;

    /**
     *
     */
    constructor(address erc721Adapter_) {
        _erc721Adapter = erc721Adapter_;
    }

    /**
     *
     */
    function erc721Adapter() public view virtual returns (address) {
        return _erc721Adapter;
    }

    /**
     *
     */
    function erc721SetApprovalForAll(
        address owner,
        address operator,
        bool approved
    ) public virtual override {
        require(
            _msgSender() == erc721Adapter(),
            "ERC1155: caller is not the token adapter"
        );
        _setApprovalForAll(owner, operator, approved);
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
    ) public virtual override {
        require(
            _msgSender() == erc721Adapter(),
            "ERC1155: caller is not the token adapter"
        );
        _transferFrom(operator, from, to, id, amount, data);
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     */
    function uri(uint256 id)
        public
        view
        virtual
        override(ERC1155Metadata, IERC1155MetadataURI)
        returns (string memory)
    {
        return super.uri(id);
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 id)
        public
        view
        virtual
        override(ERC1155Ownable, IERC1155Exists)
        returns (bool)
    {
        return super.exists(id);
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
