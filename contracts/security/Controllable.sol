/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

/**
 *
 */
contract Controllable {
    /**
     * @dev Emitted when the controller is set.
     */
    event Controller(address account);
    /**
     *
     */
    address internal _controller;

    /**
     *
     */
    constructor(address controller_) {
        _controller = controller_;
        emit Controller(controller_);
    }

    /**
     *
     */
    function controller() public view returns (address) {
        return _controller;
    }
}
