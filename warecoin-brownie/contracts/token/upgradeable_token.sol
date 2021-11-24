// SPDX-License-Identifier: GPL-3.0
// Author: Juan Pablo Crespi

pragma solidity >=0.6.0 <0.9.0;

import "./mintable_token.sol";
import "./upgradeable.sol";

interface IERC20Legacy {
    function legacyTransfer(
        address _sender,
        address _to,
        uint256 _value
    ) external returns (bool success);

    function legacyTransferFrom(
        address _sender,
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);

    function legacyApprove(
        address _sender,
        address _spender,
        uint256 _value
    ) external returns (bool success);
}

contract UpgradeableToken is MintableToken, Upgradeable, IERC20Legacy {
    function name() public view override returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).name();
        } else {
            return StandardToken.name();
        }
    }

    function symbol() public view override returns (string memory) {
        if (upgraded()) {
            return IERC20(upgradedContract()).symbol();
        } else {
            return StandardToken.symbol();
        }
    }

    function decimals() public view override returns (uint8) {
        if (upgraded()) {
            return IERC20(upgradedContract()).decimals();
        } else {
            return StandardToken.decimals();
        }
    }

    function totalSupply() public view override returns (uint256) {
        if (upgraded()) {
            return IERC20(upgradedContract()).totalSupply();
        } else {
            return StandardToken.totalSupply();
        }
    }

    function balanceOf(address _owner)
        public
        view
        override
        returns (uint256 balance)
    {
        if (upgraded()) {
            return IERC20(upgradedContract()).balanceOf(_owner);
        } else {
            return StandardToken.balanceOf(_owner);
        }
    }

    function allowance(address _owner, address _spender)
        public
        view
        override
        returns (uint256 remaining)
    {
        if (upgraded()) {
            return IERC20(upgradedContract()).allowance(_owner, _spender);
        } else {
            return StandardToken.allowance(_owner, _spender);
        }
    }

    function transfer(address _to, uint256 _value)
        public
        override
        returns (bool success)
    {
        if (upgraded()) {
            return
                IERC20Legacy(upgradedContract()).legacyTransfer(
                    _msgSender(),
                    _to,
                    _value
                );
        } else {
            return StandardToken.transfer(_to, _value);
        }
    }

    function approve(address _spender, uint256 _value)
        public
        override
        returns (bool success)
    {
        if (upgraded()) {
            return
                IERC20Legacy(upgradedContract()).legacyApprove(
                    _msgSender(),
                    _spender,
                    _value
                );
        } else {
            return StandardToken.approve(_spender, _value);
        }
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override returns (bool success) {
        if (upgraded()) {
            return
                IERC20Legacy(upgradedContract()).legacyTransferFrom(
                    _msgSender(),
                    _from,
                    _to,
                    _value
                );
        } else {
            return StandardToken.transferFrom(_from, _to, _value);
        }
    }

    function increaseAllowance(address _spender, uint256 _value)
        public
        override
        returns (bool success)
    {
        if (upgraded()) {
            return
                IERC20(upgradedContract()).increaseAllowance(_spender, _value);
        } else {
            return StandardToken.increaseAllowance(_spender, _value);
        }
    }

    function decreaseAllowance(address _spender, uint256 _value)
        public
        override
        returns (bool success)
    {
        if (upgraded()) {
            return
                IERC20(upgradedContract()).decreaseAllowance(_spender, _value);
        } else {
            return StandardToken.decreaseAllowance(_spender, _value);
        }
    }

    function getOwner() public view override returns (address) {
        if (upgraded()) {
            return IBEP20(upgradedContract()).getOwner();
        } else {
            return StandardToken.getOwner();
        }
    }

    function legacyTransfer(
        address _sender,
        address _to,
        uint256 _value
    ) public override onlyLegacy returns (bool success) {
        _transfer(_sender, _to, _value);
        return true;
    }

    function legacyApprove(
        address _sender,
        address _spender,
        uint256 _value
    ) public override onlyLegacy returns (bool success) {
        _approve(_sender, _spender, _value);
        return true;
    }

    function legacyTransferFrom(
        address _sender,
        address _from,
        address _to,
        uint256 _value
    ) public override onlyLegacy returns (bool success) {
        _transferFrom(_sender, _from, _to, _value);
        return true;
    }
}