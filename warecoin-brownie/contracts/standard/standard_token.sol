// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi

pragma solidity >=0.6.0 <0.9.0;

import "../common/ownable.sol";
import "../common/safe_math.sol";
import "./pausable.sol";
import "./blacklistable.sol";
import "./taxable.sol";

interface IERC20 {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address _owner) external view returns (uint256 balance);

    function transfer(address _to, uint256 _value)
        external
        returns (bool success);

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);

    function approve(address _spender, uint256 _value)
        external
        returns (bool success);

    function allowance(address _owner, address _spender)
        external
        view
        returns (uint256 remaining);

    function increaseAllowance(address _spender, uint256 _value)
        external
        returns (bool success);

    function decreaseAllowance(address _spender, uint256 _value)
        external
        returns (bool success);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

interface IBEP20 is IERC20 {
    function getOwner() external view returns (address);
}

contract StandardToken is IERC20, IBEP20, Pausable, Blacklistable, Taxable {
    using SafeMath for uint256;

    string internal _name;
    string internal _symbol;
    uint8 internal _decimals;
    uint256 internal _totalSupply;
    mapping(address => uint256) internal _balances;
    mapping(address => mapping(address => uint256)) internal _allowed;

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner)
        public
        view
        virtual
        override
        returns (uint256 balance)
    {
        return _balances[_owner];
    }

    function transfer(address _to, uint256 _value)
        public
        virtual
        override
        returns (bool success)
    {
        _transfer(_msgSender(), _to, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        virtual
        override
        returns (uint256 remaining)
    {
        return _allowed[_owner][_spender];
    }

    function approve(address _spender, uint256 _value)
        public
        virtual
        override
        returns (bool success)
    {
        _approve(_msgSender(), _spender, _value);
        return true;
    }

    function increaseAllowance(address _spender, uint256 _value)
        public
        virtual
        override
        returns (bool success)
    {
        _approve(
            _msgSender(),
            _spender,
            _allowed[_msgSender()][_spender].add(_value)
        );
        return true;
    }

    function decreaseAllowance(address _spender, uint256 _value)
        public
        virtual
        override
        returns (bool success)
    {
        _approve(
            _msgSender(),
            _spender,
            _allowed[_msgSender()][_spender].sub(_value)
        );
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public virtual override returns (bool success) {
        _transferFrom(_msgSender(), _from, _to, _value);
        return true;
    }

    function getOwner() public view virtual override returns (address) {
        return owner();
    }

    function _transfer(
        address _sender,
        address _to,
        uint256 _value
    ) internal whenNotPaused notBlacklisted(_sender) notBlacklisted(_to) {
        require(_sender != address(0), "ERC20: transfer from the zero address");
        require(_to != address(0), "ERC20: transfer to the zero address");
        require(
            _value <= _balances[_sender],
            "ERC20: transfer amount exceeds balance"
        );
        uint256 _fee = _calculateFee(_sender, _value);
        if (_fee > 0) {
            address _taxer = taxer();
            _balances[_taxer] = _balances[_taxer].add(_fee);
            emit Transfer(_sender, _taxer, _fee);
        }
        _balances[_sender] = _balances[_sender].sub(_value);
        _balances[_to] = _balances[_to].add(_value.sub(_fee));
        emit Transfer(_sender, _to, _value);
    }

    function _approve(
        address _sender,
        address _spender,
        uint256 _value
    ) internal whenNotPaused notBlacklisted(_sender) notBlacklisted(_spender) {
        require(_sender != address(0), "ERC20: approve from the zero address");
        require(_spender != address(0), "ERC20: approve to the zero address");
        _allowed[_sender][_spender] = _value;
        emit Approval(_sender, _spender, _value);
    }

    function _transferFrom(
        address _sender,
        address _from,
        address _to,
        uint256 _value
    )
        internal
        whenNotPaused
        notBlacklisted(_sender)
        notBlacklisted(_from)
        notBlacklisted(_to)
    {
        require(
            _value <= _allowed[_from][_sender],
            "ERC20: transfer amount exceeds allowance"
        );
        _transfer(_from, _to, _value);
        _allowed[_from][_sender] = _allowed[_from][_sender].sub(_value);
    }
}
