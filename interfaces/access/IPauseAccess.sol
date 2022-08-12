/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

interface IPauseAccess {
    /**
     *
     */
    function isPauser(address account) external view returns (bool);
}
