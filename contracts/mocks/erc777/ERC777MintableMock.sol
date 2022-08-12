// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc777/extensions/ERC777Mintable.sol";

/**
 *
 */
contract ERC777MintableMock is ERC777Mintable {
    /**
     *
     */
    constructor(address controller_) ERC777Accesable(controller_) {}
}
