/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "./IERC1155.sol";
import "./IERC1155Supply.sol";
import "./IERC1155Exists.sol";

/**
 *
 */
interface IERC1155ERC20 is IERC1155, IERC1155Supply, IERC1155Exists {
    /**
     *
     */
    function erc20Owner(uint256 id) external view returns (address);

    /**
     *
     */
    function erc20Adapter(uint256 id) external view returns (address);

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
    ) external;
}
