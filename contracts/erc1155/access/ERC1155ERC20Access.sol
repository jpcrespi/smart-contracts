/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/BurnAccess.sol";
import "../../access/MintAccess.sol";
import "../../access/PauseAccess.sol";
import "../../access/EditAccess.sol";
import "../../access/AdaptAccess.sol";

/**
 *
 */
contract ERC1155ERC20Access is
    BurnAccess,
    MintAccess,
    PauseAccess,
    EditAccess,
    AdaptAccess
{

}
