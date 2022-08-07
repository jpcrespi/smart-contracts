/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

pragma solidity ^0.8.0;

import "../../access/extensions/BurnAccess.sol";
import "../../access/extensions/MintAccess.sol";
import "../../access/extensions/PauseAccess.sol";
import "../../access/extensions/AdapterAccess.sol";

/**
 *
 */
contract ERC1155Controller is
    Accesable,
    BurnAccess,
    MintAccess,
    PauseAccess,
    AdapterAccess
{
    /**
     *
     */
    constructor(address account) Accesable(account) {}
}
