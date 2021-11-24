// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi

pragma solidity >=0.6.0 <0.9.0;

import "../common/safe_math.sol";
import "../standard/standard_token.sol";

contract MintableToken is StandardToken {
    using SafeMath for uint256;

    event Mint(address _minter, address indexed _to, uint256 _value);
    event Burn(address _burner, address indexed _from, uint256 _value);
    event MinterChanged(address indexed _account);

    address private _minter;

    constructor() {
        _minter = _msgSender();
    }

    modifier onlyMinter() {
        require(_msgSender() == _minter, "Mintable: caller is not a minter");
        _;
    }

    function minter() public view returns (address) {
        return _minter;
    }

    function updateMinter(address _account) public onlyOwner {
        require(
            _account != address(0),
            "Mintable: new miner is the zero address"
        );
        _minter = _account;
        emit MinterChanged(_account);
    }

    function mint(address _to, uint256 _value) public {
        _mint(_msgSender(), _to, _value);
    }

    function burn(address _from, uint256 _value) public {
        _burn(_msgSender(), _from, _value);
    }

    function burnFrom(address _from, uint256 _value) internal {
        _burn(_msgSender(), _from, _value);
        _approve(
            _from,
            _msgSender(),
            _allowed[_from][_msgSender()].sub(_value)
        );
    }

    function _mint(
        address _sender,
        address _to,
        uint256 _value
    )
        internal
        whenNotPaused
        onlyMinter
        notBlacklisted(_sender)
        notBlacklisted(_to)
    {
        require(_to != address(0), "Mintable: mint to the zero address");
        require(_value > 0, "Mintable: mint amount not greater than 0");
        _totalSupply = _totalSupply.add(_value);
        _balances[_to] = _balances[_to].add(_value);
        emit Mint(_sender, _to, _value);
        emit Transfer(address(0), _to, _value);
    }

    function _burn(
        address _sender,
        address _from,
        uint256 _value
    ) internal whenNotPaused onlyMinter notBlacklisted(_sender) {
        require(_from != address(0), "Mintable: burn to the zero address");
        uint256 _balance = _balances[_from];
        require(_value > 0, "Mintable: burn amount not greater than 0");
        require(_balance >= _value, "Mintable: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(_value);
        _balances[_from] = _balance.sub(_value);
        emit Burn(_sender, _from, _value);
        emit Transfer(_from, address(0), _value);
    }
}
