// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc777/backward/ERC777ERC20Approve.sol";

/**
 *
 */
contract ERC777ERC20ApproveMock is ERC777ERC20Approve {
    /**
     *
     */
    constructor(address controller_) ERC777Accesable(controller_) {}
}
