// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./ERC1155Supply.sol";
import "../../../interfaces/erc1155/IERC1155Ownable.sol";

/**
 * @dev Extension of ERC1155 that adds tracking of total supply per id.
 *
 * Useful for scenarios where Fungible and Non-fungible tokens have to be
 * clearly identified. Note: While a totalSupply of 1 might mean the
 * corresponding is an NFT, there is no guarantees that no other token with the
 * same id are not going to be minted.
 */
contract ERC1155Ownable is ERC1155Supply, IERC1155Ownable {
    // Mapping owner address to token count
    mapping(address => uint256) internal _tokenBalances;
    // Mapping from token ID to owner address
    mapping(uint256 => address) internal _tokenOwners;

    /**
     *
     */
    function erc721Token(uint256 id) public view virtual returns (bool) {
        return totalSupply(id) == 1;
    }

    /**
     *
     */
    function balanceOf(address owner)
        public
        view
        virtual
        override
        returns (uint256)
    {
        require(
            owner != address(0),
            "ERC1155Ownable: address zero is not a valid owner"
        );
        return _tokenBalances[owner];
    }

    /**
     *
     */
    function ownerOf(uint256 id)
        public
        view
        virtual
        override
        returns (address)
    {
        address owner = _tokenOwners[id];
        require(
            owner != address(0),
            "ERC1155Ownable: owner query for nonexistent token"
        );
        return owner;
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
        //Mint
        if (from == address(0)) {
            for (uint256 i = 0; i < ids.length; ++i) {
                uint256 id = ids[i];
                if (erc721Token(id)) {
                    _tokenBalances[to] += 1;
                    _tokenOwners[id] = to;
                }
            }
        }
        // Burn
        else if (to == address(0)) {
            for (uint256 i = 0; i < ids.length; ++i) {
                uint256 id = ids[i];
                if (erc721Token(id)) {
                    unchecked {
                        _tokenBalances[from] -= 1;
                        delete _tokenOwners[id];
                    }
                }
            }
        }
        // Tranfer
        else {
            for (uint256 i = 0; i < ids.length; ++i) {
                uint256 id = ids[i];
                if (erc721Token(id)) {
                    unchecked {
                        _tokenBalances[from] -= 1;
                        _tokenBalances[to] += 1;
                        _tokenOwners[id] = to;
                    }
                }
            }
        }
    }
}
