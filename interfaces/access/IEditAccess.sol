/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

interface IEditAccess {
    /**
     *
     */
    function isEditor(address account) external view returns (bool);
}
