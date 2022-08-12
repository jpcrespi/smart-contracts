/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

interface IAdaptAccess {
    /**
     *
     */
    function isAdapter(address account) external view returns (bool);
}
