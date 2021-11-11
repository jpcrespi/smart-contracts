// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi 

pragma solidity >=0.6.0 <0.9.0;

import "../Common/Ownable.sol";

contract Upgradeable is Ownable {

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
    
    function upgradeContract(address _newContract) public onlyUpgrader {
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
}
