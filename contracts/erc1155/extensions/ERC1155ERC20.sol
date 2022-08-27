/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155ERC20.sol";
import "./ERC1155Supply.sol";

/**
 *
 */
abstract contract ERC1155ERC20 is ERC1155Supply, IERC1155ERC20 {
    // Mapping token id to adapter address
    mapping(uint256 => address) internal _erc20Adapters;

    /**
     *
     */
    event Adapter(uint256 indexed id, address indexed adapter);

    /**
     *
     */
    function erc20Adapter(uint256 id) public view virtual returns (address) {
        return _erc20Adapters[id];
    }

    /**
     *
     */
    function erc20TransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(
            _msgSender() == erc20Adapter(id),
            "ERC1155: caller is not the token adapter"
        );
        _transferFrom(operator, from, to, id, amount, data);
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return erc20Adapter(tokenId) != address(0);
    }

    /**
     *
     */
    function _setERC20Adapter(uint256 tokenId, address erc20Adapter_)
        internal
        virtual
    {
        _erc20Adapters[tokenId] = erc20Adapter_;
        emit Adapter(tokenId, erc20Adapter_);
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
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
        for (uint256 i = 0; i < ids.length; ++i) {
            uint256 tokenId = ids[i];
            require(
                exists(tokenId),
                "ERC1155: token does not exist (missing ERC20Adapter)"
            );
        }
    }
}
