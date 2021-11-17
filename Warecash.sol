// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi 

pragma solidity >=0.6.0 <0.9.0;

library SafeMath {

    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return add(a, b, "SafeMath: addition overflow");
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return mul(a, b, "SafeMath: multiplication overflow");
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function add(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            uint256 c = a + b;
            require(c >= a, errorMessage);
            return c;
        }
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    function mul(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            uint256 c = a * b;
            require(c / a == b, errorMessage);
            return c;
        }
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

interface IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    function increaseAllowance(address _spender, uint256 _value) external returns (bool success);
    function decreaseAllowance(address _spender, uint256 _value) external returns (bool success);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

interface IBEP20 is IERC20 {
    function getOwner() external view returns (address);
}

interface IERC20Legacy {
    function legacyTransfer(address _sender, address _to, uint256 _value) external returns (bool success);
    function legacyTransferFrom(address _sender, address _from, address _to, uint256 _value) external returns (bool success);
    function legacyApprove(address _sender, address _spender, uint256 _value) external returns (bool success);
}

contract Warecash is IERC20, IBEP20, IERC20Legacy {
    using SafeMath for uint256;

    event OwnershipTransferred(address indexed _previousOwner, address indexed _newOwner);
    event Params(uint256 _feeRate, uint256 _maximumFee);
    event TaxerChanged(address indexed _account);
    event Blacklisted(address indexed _account);
    event UnBlacklisted(address indexed _account);
    event BlacklisterChanged(address indexed _account);
    event Pause();
    event Unpause();
    event PauserChanged(address indexed _account);
    event Mint(address _minter, address indexed _to, uint256 _value);
    event Burn(address _burner, address indexed _from, uint256 _value);
    event MinterChanged(address indexed _account);
    event Upgraded(address indexed _newContract);
    event Legacy(address indexed _oldContract);
    event UpgraderChanged(address indexed _account);

    address private _owner;
    address private _taxer;
    uint256 private _feeRate;
    uint256 private _maximumFee;
    address private _blacklister;
    mapping(address => bool) private _blacklisted;
    address private _pauser;
    bool private _paused = false;
    string internal _name;
    string internal _symbol;
    uint8 internal _decimals;
    uint256 internal _totalSupply;
    mapping(address => uint256) internal _balances;
    mapping(address => mapping(address => uint256)) internal _allowed;
    address private _minter;
    address private _upgrader;
    address private _legacyContract;
    address private _upgradedContract;
    bool private _upgraded;
    
    constructor() {
        _owner = _msgSender();
        _taxer = _msgSender();
        _blacklister = _msgSender();
        _pauser = _msgSender();
        _minter = _msgSender();
        _upgrader = _msgSender();
        _name = "Warecash";
        _symbol = "WC";
        _decimals = 8;
    }

    // Context
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    // Ownable

    modifier onlyOwner() {
        require(_msgSender() == _owner, "Ownable: caller is not the owner");
        _;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, _newOwner);
        _owner = _newOwner;
    }

    // Taxable
    function taxer() public view returns (address) {
        return _taxer;
    }

    function updateTaxer(address _account) public onlyOwner {
        require(_account != address(0), "Taxable: new feer is the zero address");
        _taxer = _account;
        emit TaxerChanged(_account);
    }
    
    function setParams(uint256 _newFeeRate, uint256 _newMaximumFee, uint256 _newDecimals) public onlyOwner {
        require(_newFeeRate < 20);
        require(_newMaximumFee < 50);
        _feeRate = _newFeeRate;
        _maximumFee = _newMaximumFee.mul(10**_newDecimals);
        emit Params(_feeRate, _maximumFee);
    }
    
    function feeRate() public view returns (uint256) {
        return _feeRate;
    }
    
    function maximumFee() public view returns (uint256) {
        return _maximumFee;
    }
    
    function _calculateFee(address _sender, uint256 _value) internal view returns (uint256) {
        if (_sender == _taxer) {
            return 0;
        }
        uint256 _fee = (_value.mul(_feeRate).div(10000));
        if (_fee > _maximumFee) {
            _fee = _maximumFee;
        }
        return _fee;
    }

    // Blacklistable
    modifier onlyBlacklister() {
        require(_msgSender() == _blacklister, "Blacklistable: caller is not the blacklister");
        _;
    }

    modifier notBlacklisted(address _account) {
        require(_blacklisted[_account] == false, "Blacklistable: account is blacklisted");
        _;
    }

    function blacklister() public view returns (address) {
        return _blacklister;
    }

    function updateBlacklister(address _account) public onlyOwner {
        require(_account != address(0), "Blacklistable: new blacklister is the zero address");
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

    // Pausable
    modifier whenNotPaused() {
        require(_paused == false, "Pausable: paused");
        _;
    }

    modifier whenPaused {
        require(_paused == true, "Pausable: not paused") ;
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
        require(_account != address(0), "Pausable: new pauser is the zero address");
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

    // ERC20
    function _transfer(address _sender, address _to, uint256 _value) internal whenNotPaused notBlacklisted(_sender) notBlacklisted(_to)  {
        require(_sender != address(0), "ERC20: transfer from the zero address");
        require(_to != address(0), "ERC20: transfer to the zero address");
        require(_value <= _balances[_sender],"ERC20: transfer amount exceeds balance");
        uint256 _fee = _calculateFee(_sender, _value);
        if (_fee > 0) {
            address _account = taxer();
            _balances[_account] = _balances[_account].add(_fee);
            emit Transfer(_sender, _account, _fee);
        }
        _balances[_sender] = _balances[_sender].sub(_value);
        _balances[_to] = _balances[_to].add(_value.sub(_fee));
        emit Transfer(_sender, _to, _value);
    }
    
    function _approve(address _sender, address _spender, uint256 _value) internal whenNotPaused notBlacklisted(_sender) notBlacklisted(_spender) {
        require(_sender != address(0), "ERC20: approve from the zero address");
        require(_spender != address(0), "ERC20: approve to the zero address");
        _allowed[_sender][_spender] = _value;
        emit Approval(_sender, _spender, _value);
    }
    
    function _transferFrom(address _sender, address _from, address _to, uint256 _value) internal whenNotPaused notBlacklisted(_sender) notBlacklisted(_from) notBlacklisted(_to) {
        require(_value <= _allowed[_from][_sender], "ERC20: transfer amount exceeds allowance");
        _transfer(_from, _to, _value);
        _allowed[_from][_sender] = _allowed[_from][_sender].sub(_value);
    }

    //Mintable
    modifier onlyMinter() {
        require(_msgSender() == _minter, "Mintable: caller is not a minter");
        _;
    }

    function minter() public view returns (address) {
        return _minter;
    }

    function updateMinter(address _account) public onlyOwner {
        require(_account != address(0), "Mintable: new miner is the zero address" );
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
        _approve(_from, _msgSender(), _allowed[_from][_msgSender()].sub(_value));
    }
    
    function _mint(address _sender, address _to, uint256 _value) internal whenNotPaused onlyMinter notBlacklisted(_sender) notBlacklisted(_to) {
        require(_to != address(0), "Mintable: mint to the zero address");
        require(_value > 0, "Mintable: mint amount not greater than 0");
        _totalSupply = _totalSupply.add(_value);
        _balances[_to] = _balances[_to].add(_value);
        emit Mint(_sender, _to, _value);
        emit Transfer(address(0), _to, _value);
    }
    
    function _burn(address _sender, address _from, uint256 _value) internal whenNotPaused onlyMinter notBlacklisted(_sender) {
        require(_from != address(0), "Mintable: burn to the zero address");
        uint256 _balance = _balances[_from];
        require(_value > 0, "Mintable: burn amount not greater than 0");
        require(_balance >= _value, "Mintable: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(_value);
        _balances[_from] = _balance.sub(_value);
        emit Burn(_sender, _from, _value);
        emit Transfer(_from, address(0), _value);
    }

    // Upgradeable
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

    function name() override public view returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).name();
        } else {
            return _name;
        }
    }

    function symbol() override public view returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).symbol();
        } else { 
            return _symbol;
        }
    }

    function decimals() override public view returns (uint8) {
        if (upgraded()) {
            return IERC20(upgradedContract()).decimals();
        } else {
            return _decimals;
        }
    }

    function totalSupply() override public view returns (uint256) {
        if (upgraded()) {
            return IERC20(upgradedContract()).totalSupply();
        } else {
            return _totalSupply;
        }
    }

    function balanceOf(address _from) override public view returns (uint256 balance) {
        if (upgraded()) {
            return IERC20(upgradedContract()).balanceOf(_owner);
        } else {
            return _balances[_from];
        }
    }

    function allowance(address _from, address _spender) override public view returns (uint256 remaining) {
        if (upgraded()) {
            return IERC20(upgradedContract()).allowance(_from, _spender);
        } else {
            return _allowed[_from][_spender];
        }
    }

    function transfer(address _to, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyTransfer(_msgSender(), _to, _value);
        } else {
            _transfer(_msgSender(), _to, _value);
            return true;
        }
    }

    function approve(address _spender, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyApprove(_msgSender(), _spender, _value);
        } else {
            _approve(_msgSender(), _spender, _value);
            return true;
        }
    }

    function transferFrom(address _from, address _to, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyTransferFrom(_msgSender(), _from, _to, _value);
        } else {
            _transferFrom(_msgSender(), _from, _to, _value);
            return true;
        }
    }

    function increaseAllowance(address _spender, uint256 _value) override public returns (bool success) {
        uint256 newvValue = _allowed[_msgSender()][_spender].add(_value);
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyApprove(_msgSender(), _spender, newvValue);
        } else {
            _approve(_msgSender(), _spender, newvValue);
            return true;
        }
    }

    function decreaseAllowance(address _spender, uint256 _value) override public returns (bool success) {
        uint256 newValue = _allowed[_msgSender()][_spender].sub(_value);
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyApprove(_msgSender(), _spender, newValue);
        } else {
            _approve(_msgSender(), _spender, newValue);
            return true;
        }
    }

    function getOwner() override public view returns (address) {
        if (upgraded()) {
            return IBEP20(upgradedContract()).getOwner();
        } else {
            return owner();
        }
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