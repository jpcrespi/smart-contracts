/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../ERC20.sol";
import "../controller/ERC20Controller.sol";

/**
*
 */
contract ERC20Accesable is ERC20 {
    /**
     *
     */
    ERC20Controller internal _controller;

    /**
     *
     */
    constructor() {
        _controller = new ERC20Controller(_msgSender());
    }

    /**
     *
     */
    function controller() public view returns (address) {
        return address(_controller);
    }
}
