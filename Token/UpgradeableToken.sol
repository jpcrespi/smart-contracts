// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi 

pragma solidity >=0.6.0 <0.9.0;

import "./MintableToken.sol";
import "./Upgradeable.sol";

interface IERC20Legacy {
    function legacyTransfer(address _sender, address _to, uint256 _value) external returns (bool success);
    function legacyTransferFrom(address _sender, address _from, address _to, uint256 _value) external returns (bool success);
    function legacyApprove(address _sender, address _spender, uint256 _value) external returns (bool success);
}

contract UpgradeableToken is MintableToken, Upgradeable, IERC20Legacy {

    function name() override public view returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).name();
        } else {
            return StandardToken.name();
        }
    }

    function symbol() override public view returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).symbol();
        } else { 
            return StandardToken.symbol();
        }
    }

    function decimals() override public view returns (uint8) {
        if (upgraded()) {
            return IERC20(upgradedContract()).decimals();
        } else {
            return StandardToken.decimals();
        }
    }

    function totalSupply() override public view returns (uint256) {
        if (upgraded()) {
            return IERC20(upgradedContract()).totalSupply();
        } else {
            return StandardToken.totalSupply();
        }
    }

    function balanceOf(address _owner) override public view returns (uint256 balance) {
        if (upgraded()) {
            return IERC20(upgradedContract()).balanceOf(_owner);
        } else {
            return StandardToken.balanceOf(_owner);
        }
    }

    function allowance(address _owner, address _spender) override public view returns (uint256 remaining) {
        if (upgraded()) {
            return IERC20(upgradedContract()).allowance(_owner, _spender);
        } else {
            return StandardToken.allowance(_owner, _spender);
        }
    }

    function transfer(address _to, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyTransfer(_msgSender(), _to, _value);
        } else {
            return StandardToken.transfer(_to, _value);
        }
    }

    function approve(address _spender, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyApprove(_msgSender(), _spender, _value);
        } else {
            return StandardToken.approve(_spender, _value);
        }
    }

    function transferFrom(address _from, address _to, uint256 _value) override public returns (bool success) {
        if (upgraded()) {
            return IERC20Legacy(upgradedContract()).legacyTransferFrom(_msgSender(), _from, _to, _value);
        } else {
            return StandardToken.transferFrom(_from, _to, _value);
        }
    }

    function getOwner() override public view returns (address) {
        if (upgraded()) {
            return IBEP20(upgradedContract()).getOwner();
        } else {
            return StandardToken.getOwner();
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