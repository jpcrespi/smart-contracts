/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";

/**
 *
 */
contract Controllable {
    //
    address internal _controller;

    /**
     * @dev Emitted when the controller is set.
     */
    event ControlTransferred(address indexed newController);

    /**
     *
     */
    constructor(address controller_) {
        _transferControl(controller_);
    }

    /**
     *
     */
    function controller() public view returns (address) {
        return _controller;
    }

    /**
     * @dev Transfers control of the contract to a new account (`newController`).
     * Internal function without access restriction.
     */
    function _transferControl(address newController) internal virtual {
        require(
            newController != address(0),
            "Controllable: controller is the zero address"
        );
        require(
            IERC165(newController).supportsInterface(
                type(IAccessControl).interfaceId
            ),
            "Controllable: controller does not support IAccessControl interface"
        );
        _controller = newController;
        emit ControlTransferred(newController);
    }
}
