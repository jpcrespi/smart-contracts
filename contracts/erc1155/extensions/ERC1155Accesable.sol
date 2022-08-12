/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC1155.sol";

/**
 * @dev Implementation of the basic standard multi-token.
 * See https://eips.ethereum.org/EIPS/eip-1155
 * Originally based on code by Enjin: https://github.com/enjin/erc-1155
 *
 * _Available since v3.1._
 */
contract ERC1155Accesable is ERC1155 {
    /**
     *
     */
    address internal _controller;

    /**
     *
     */
    constructor(address controller_) {
        _controller = controller_;
    }

    /**
     *
     */
    function controller() public view returns (address) {
        return _controller;
    }
}
