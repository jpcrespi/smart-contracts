// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (a controller) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyController`, which can be applied to your functions to restrict their use to
 * the controller.
 */
contract Controllable is Context {
    address private _controller;

    /**
     * @dev Initializes the contract setting the deployer as the initial controller.
     */
    constructor() {
        _controller = _msgSender();
    }

    /**
     * @dev Returns the address of the current controller.
     */
    function controller() public view virtual returns (address) {
        return _controller;
    }

    /**
     * @dev Throws if called by any account other than the controller.
     */
    modifier onlyController() {
        require(
            controller() == _msgSender(),
            "Controllable: caller is not the controller"
        );
        _;
    }
}
