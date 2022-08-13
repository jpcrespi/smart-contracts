/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../access/BurnAccess.sol";
import "../../access/MintAccess.sol";
import "../../access/PauseAccess.sol";

/**
 *
 */
contract ERC721Access is BurnAccess, MintAccess, PauseAccess {

}
