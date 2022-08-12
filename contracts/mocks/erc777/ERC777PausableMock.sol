// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc777/extensions/ERC777Pausable.sol";

/**
 *
 */
contract ERC777PausableMock is ERC777Pausable {
    /**
     *
     */
    constructor(address controller_) ERC777Accesable(controller_) {}
}
