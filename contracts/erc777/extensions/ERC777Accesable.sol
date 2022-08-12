/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC777.sol";

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
