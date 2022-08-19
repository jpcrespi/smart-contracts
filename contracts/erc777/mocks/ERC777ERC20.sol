// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc777/backward/ERC777ERC20.sol";

/**
 *
 */
contract ERC777ERC20Mock is ERC777ERC20 {
    /**
     *
     */
    constructor(address controller_) Controllable(controller_) {}
}
