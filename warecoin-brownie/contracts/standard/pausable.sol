// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi

pragma solidity >=0.6.0 <0.9.0;

import "../common/ownable.sol";

contract Pausable is Ownable {
    event Pause();
    event Unpause();
    event PauserChanged(address indexed _account);

    address private _pauser;
    bool private _paused = false;

    constructor() {
        _pauser = _msgSender();
    }

    modifier whenNotPaused() {
        require(_paused == false, "Pausable: paused");
        _;
    }

    modifier whenPaused() {
        require(_paused == true, "Pausable: not paused");
        _;
    }

    modifier onlyPauser() {
        require(_msgSender() == _pauser, "Pausable: caller is not the pauser");
        _;
    }

    function paused() public view returns (bool) {
        return _paused == true;
    }

    function pauser() public view returns (address) {
        return _pauser;
    }

    function updatePauser(address _account) public onlyOwner {
        require(
            _account != address(0),
            "Pausable: new pauser is the zero address"
        );
        _pauser = _account;
        emit PauserChanged(_account);
    }

    function pause() public onlyPauser whenNotPaused returns (bool success) {
        _paused = true;
        emit Pause();
        return true;
    }

    function unpause() public onlyPauser whenPaused returns (bool success) {
        _paused = false;
        emit Unpause();
        return true;
    }
}
