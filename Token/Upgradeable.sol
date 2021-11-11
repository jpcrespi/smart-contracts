// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi 

pragma solidity >=0.6.0 <0.9.0;

import "../Standard/Token.sol";

interface IERC20Legacy {
    function legacyTransfer(address _sender, address _to, uint256 _value) external returns (bool success);
    function legacyTransferFrom(address _sender, address _from, address _to, uint256 _value) external returns (bool success);
    function legacyApprove(address _sender, address _spender, uint256 _value) external returns (bool success);
}

contract Upgradeable is StandardToken, IERC20Legacy {

    event Upgraded(address indexed _newContract);
    event Legacy(address indexed _oldContract);
    event UpgraderChanged(address indexed _account);

    address private _upgrader;
    address private _legacyContract;
    address private _upgradedContract;
    bool private _upgraded;

    constructor() {
        _upgrader = _msgSender();
    }

    modifier onlyUpgrader() {
        require(_msgSender() == _upgrader, "Upgradeable: caller is not the upgrader");
        _;
    }

    modifier onlyLegacy() {
        require(_msgSender() != address(0), "Upgradeable: caller is the zero address");
        require(_msgSender() == _legacyContract, "Upgradeable: caller is not the legacy contract");
        _;
    }

    function upgrader() public view returns (address) {
        return _upgrader;
    }

    function updateUpgrader(address _account) public onlyOwner {
        require(_account != address(0), "Upgradeable: new upgrader is the zero address");
        _upgrader = _account;
        emit UpgraderChanged(_account);
    }

    function legacyContract(address _oldContract) public onlyUpgrader {
        _legacyContract = _oldContract;
        emit Legacy(_oldContract);
    }

    function legacyContract() public view returns (address) {
        return _legacyContract;
    }
    
    function upgradedContract(address _newContract) public onlyUpgrader {
        _upgraded = true;
        _upgradedContract = _newContract;
        emit Upgraded(_newContract);
    }
    
    function upgradedContract() public view returns (address) {
        return _upgradedContract;
    }
    
    function upgraded() public view returns (bool) {
        return _upgraded;
    }

    function legacyTransfer(address _sender, address _to, uint256 _value) override public onlyLegacy returns (bool success) {
        _transfer(_sender, _to, _value);
        return true;
    }

    function legacyApprove(address _sender, address _spender, uint256 _value) override public onlyLegacy returns (bool success) {
        _approve(_sender, _spender, _value);
        return true;
    }
    
    function legacyTransferFrom(address _sender, address _from, address _to, uint256 _value) override public onlyLegacy returns (bool success) {
        _transferFrom(_sender, _from, _to, _value);
        return true;
    }
}