// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi 

pragma solidity >=0.6.0 <0.9.0;

import "../Standard/Token.sol";
import "./Mintable.sol";
import "./Upgradeable.sol";

contract Token is StandardToken, Mintable, Upgradeable {

    function name() override public view returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).name();
        } else {
            return super.name();
        }
    }

    function symbol() override public view returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).symbol();
        } else { 
            return super.symbol();
        }
    }

    function decimals() override public view returns (uint8) {
        if (upgraded()) {
            return IERC20(upgradedContract()).decimals();
        } else {
            return super.decimals();
        }
    }

    function totalSupply() override public view returns (uint256) {
        if (upgraded()) {
            return IERC20(upgradedContract()).totalSupply();
        } else {
            return super.totalSupply();
        }
    }

    function balanceOf(address _owner) override public view returns (uint256 balance) {
        if (upgraded()) {
            return IERC20(upgradedContract()).balanceOf(_owner);
        } else {
            return super.balanceOf(_owner);
        }
    }

    function allowance(address _owner, address _spender) override public view returns (uint256 remaining) {
        if (upgraded()) {
            return IERC20(upgradedContract()).allowance(_owner, _spender);
        } else {
            return super.allowance(_owner, _spender);
        }
    }

    function transfer(address _to, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyTransfer(_msgSender(), _to, _value);
        } else {
            return super.transfer(_to, _value);
        }
    }

    function approve(address _spender, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyApprove(_msgSender(), _spender, _value);
        } else {
            return super.approve(_spender, _value);
        }
    }

    function transferFrom(address _from, address _to, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyTransferFrom(_msgSender(), _from, _to, _value);
        } else {
            return super.transferFrom(_from, _to, _value);
        }
    }

    function getOwner() override public view returns (address) {
        if (upgraded()) {
            return IBEP20(upgradedContract()).getOwner();
        } else {
            return super.getOwner();
        }
    }
}