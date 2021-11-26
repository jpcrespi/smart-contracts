// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi

pragma solidity >=0.6.0 <0.9.0;

import "../common/SafeMath.sol";
import "../common/Ownable.sol";

contract Blacklistable is Ownable {
    using SafeMath for uint256;

    event Blacklisted(address indexed _account);
    event UnBlacklisted(address indexed _account);
    event BlacklisterChanged(address indexed _account);

    address private _blacklister;
    mapping(address => bool) private _blacklisted;

    constructor() {
        _blacklister = _msgSender();
    }

    modifier onlyBlacklister() {
        require(
            _msgSender() == _blacklister,
            "Blacklistable: caller is not the blacklister"
        );
        _;
    }

    modifier notBlacklisted(address _account) {
        require(
            _blacklisted[_account] == false,
            "Blacklistable: account is blacklisted"
        );
        _;
    }

    function blacklister() public view returns (address) {
        return _blacklister;
    }

    function updateBlacklister(address _account) public onlyOwner {
        require(
            _account != address(0),
            "Blacklistable: new blacklister is the zero address"
        );
        _blacklister = _account;
        emit BlacklisterChanged(_account);
    }

    function isBlacklisted(address _account) public view returns (bool) {
        return _blacklisted[_account];
    }

    function blacklist(address _account) public onlyBlacklister {
        _blacklisted[_account] = true;
        emit Blacklisted(_account);
    }

    function unBlacklist(address _account) public onlyBlacklister {
        _blacklisted[_account] = false;
        emit UnBlacklisted(_account);
    }
}
