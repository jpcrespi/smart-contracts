/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-721
/// @title ERC-721 Non-Fungible Token Standard, optional metadata extension
/// Note: the ERC-165 identifier for this interface is 0x5b5e139f.

pragma solidity ^0.8.0;

interface IERC721Metadata {
    /**
     * @notice A descriptive name for a collection of NFTs in this contract
     */
    function name() external view returns (string memory name);

    /**
     * @notice An abbreviated name for NFTs in this contract
     */
    function symbol() external view returns (string memory symbol);

    /**
     * @notice A distinct Uniform Resource Identifier (URI) for a given asset.
     * @dev Throws if `tokenId` is not a valid NFT. URIs are defined in RFC
     * 3986. The URI may point to a JSON file that conforms to the "ERC721
     * Metadata JSON Schema".
     */
    function tokenURI(uint256 tokenId)
        external
        view
        returns (string memory uri);
}
