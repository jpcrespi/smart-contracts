/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./IERC1155Supply.sol";
import "./IERC1155Exists.sol";

/**
 *
 */
interface IERC1155Ownable is IERC1155Supply, IERC1155Exists {
    /**
     *
     */
    function balanceOf(address owner) external view returns (uint256);

    /**
     *
     */
    function ownerOf(uint256 id) external view returns (address);
}
