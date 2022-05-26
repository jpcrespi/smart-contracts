/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC721.sol";
import "../controller/ERC721Controller.sol";

/**
 *
 */
contract ERC721Accesable is ERC721 {
    /**
     *
     */
    ERC721Controller internal _controller;

    /**
     *
     */
    constructor() {
        _controller = new ERC721Controller(_msgSender());
    }

    /**
     *
     */
    function controller() public view returns (address) {
        return address(_controller);
    }
}
