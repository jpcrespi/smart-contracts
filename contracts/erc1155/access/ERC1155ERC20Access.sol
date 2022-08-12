/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/extensions/BurnAccess.sol";
import "../../access/extensions/MintAccess.sol";
import "../../access/extensions/PauseAccess.sol";
import "../../access/extensions/AdaptAccess.sol";

/**
 *
 */
contract ERC1155ERC20Access is
    BurnAccess,
    MintAccess,
    PauseAccess,
    AdaptAccess
{

}
