// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi

pragma solidity >=0.6.0 <0.9.0;

import "../common/Ownable.sol";
import "../common/SafeMath.sol";

contract Taxable is Ownable {
    using SafeMath for uint256;

    event Params(uint256 _feeRate, uint256 _maximumFee);
    event TaxerChanged(address indexed _account);

    address private _taxer;
    uint256 private _feeRate;
    uint256 private _maximumFee;

    constructor() {
        _taxer = _msgSender();
    }

    function taxer() public view returns (address) {
        return _taxer;
    }

    function updateTaxer(address _account) public onlyOwner {
        require(
            _account != address(0),
            "Taxable: new feer is the zero address"
        );
        _taxer = _account;
        emit TaxerChanged(_account);
    }

    function setParams(
        uint256 _newFeeRate,
        uint256 _newMaximumFee,
        uint256 _decimals
    ) public onlyOwner {
        require(_newFeeRate < 20);
        require(_newMaximumFee < 50);
        _feeRate = _newFeeRate;
        _maximumFee = _newMaximumFee.mul(10**_decimals);
        emit Params(_feeRate, _maximumFee);
    }

    function feeRate() public view returns (uint256) {
        return _feeRate;
    }

    function maximumFee() public view returns (uint256) {
        return _maximumFee;
    }

    function _calculateFee(address _sender, uint256 _value)
        internal
        view
        returns (uint256)
    {
        if (_sender == _taxer) {
            return 0;
        }
        uint256 _fee = (_value.mul(_feeRate).div(10000));
        if (_fee > _maximumFee) {
            _fee = _maximumFee;
        }
        return _fee;
    }
}
