// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc777/extensions/ERC777Burnable.sol";

/**
 *
 */
contract ERC777BurnableMock is ERC777Burnable {
    /**
     *
     */
    constructor(address controller_) Controllable(controller_) {}
}
