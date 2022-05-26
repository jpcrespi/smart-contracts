/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-721
/// @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
/// Note: the ERC-165 identifier for this interface is 0x780e9d63.

pragma solidity ^0.8.0;

import "./IERC721.sol";

interface IERC721Enumerable is IERC721 {
    /**
     * @notice Count NFTs tracked by this contract
     * @return total count of valid NFTs tracked by this contract, where each one of
     * them has an assigned and queryable owner not equal to the zero address
     */
    function totalSupply() external view returns (uint256 total);

    /**
     * @notice Enumerate valid NFTs
     * @dev Throws if `_index` >= `totalSupply()`.
     * @param index A counter less than `totalSupply()`
     * @return tokenId token identifier for the `_index`th NFT,
     * (sort order not specified)
     */
    function tokenByIndex(uint256 index)
        external
        view
        returns (uint256 tokenId);

    /**
     * @notice Enumerate NFTs assigned to an owner
     * @dev Throws if `index` >= `balanceOf(owner)` or if
     * `owner` is the zero address, representing invalid NFTs.
     * @param owner An address where we are interested in NFTs owned by them
     * @param index A counter less than `balanceOf(owner)`
     * @return tokenId token identifier for the `index`th NFT assigned to `owner`,
     * (sort order not specified)
     */
    function tokenOfOwnerByIndex(address owner, uint256 index)
        external
        view
        returns (uint256 tokenId);
}
