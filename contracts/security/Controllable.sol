/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";

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
        require(
            IERC165(controller_).supportsInterface(
                type(IAccessControl).interfaceId
            ),
            "Controller does not support IAccessControl interface"
        );
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
