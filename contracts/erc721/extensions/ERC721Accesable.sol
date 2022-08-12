/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC721.sol";

/**
 *
 */
contract ERC721Accesable is ERC721 {
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
