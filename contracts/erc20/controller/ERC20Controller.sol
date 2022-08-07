/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/extensions/BurnAccess.sol";
import "../../access/extensions/MintAccess.sol";
import "../../access/extensions/PauseAccess.sol";

/**
 *
 */
contract ERC20Controller is Accesable, BurnAccess, MintAccess, PauseAccess {
    /**
     *
     */
    constructor(address account) Accesable(account) {}
}
