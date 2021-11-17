// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi 

pragma solidity >=0.6.0 <0.9.0;

import "./Context.sol";

interface IERC173 {
    function owner() view external returns(address);  
    function transferOwnership(address _newOwner) external;	
    event OwnershipTransferred(address indexed _previousOwner, address indexed _newOwner);
}

contract Ownable is Context, IERC173 {

    address private _owner;

    constructor() {
        _owner = _msgSender();
    }

    modifier onlyOwner() {
        require(_msgSender() == _owner, "Ownable: caller is not the owner");
        _;
    }

    function owner() override public view returns (address) {
        return _owner;
    }

    function transferOwnership(address _newOwner) override public onlyOwner {
        require(_newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, _newOwner);
        _owner = _newOwner;
    }
}