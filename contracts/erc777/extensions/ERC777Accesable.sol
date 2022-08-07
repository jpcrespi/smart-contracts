/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC777.sol";
import "../controller/ERC777Controller.sol";

/**
 *
 */
contract ERC777Accesable is ERC777 {
    /**
     *
     */
    address internal _controller;

    /**
     *
     */
    constructor() {
        _controller = address(new ERC777Controller(_msgSender()));
    }

    /**
     *
     */
    function controller() public view returns (address) {
        return _controller;
    }
}
