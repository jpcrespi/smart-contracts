/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc1155/IERC1155ERC20.sol";
import "./ERC1155Accesable.sol";
import "./ERC1155Supply.sol";
import {ERC20Adapter} from "../adapters/ERC20Adapter.sol";

contract ERC1155ERC20 is ERC1155Accesable, ERC1155Supply, IERC1155ERC20 {
    // Mapping token id to adapter address
    mapping(uint256 => address) internal _erc20;

    /**
     *
     */
    event Adapter(uint256 indexed id, address indexed adapter);

    /**
     *
     */
    function create(
        uint256 id_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) public virtual {
        require(
            AdapterAccess(_controller).isAdapter(_msgSender()),
            "ERC1155: caller is not the token adapter"
        );
        require(
            _erc20[id_] == address(0),
            "ER1C155: cannot create token adapter, already exist"
        );
        address adapter = address(
            new ERC20Adapter(id_, name_, symbol_, decimals_)
        );
        _erc20[id_] = adapter;
        emit Adapter(id_, adapter);
    }

    /**
     *
     */
    function erc20Adapter(uint256 id) public view virtual returns (address) {
        return _erc20[id];
    }

    /**
     *
     */
    function erc20Owner(uint256) public view virtual returns (address) {
        return controller();
    }

    /**
     *
     */
    function erc20TransferFrom(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(
            _msgSender() == erc20Adapter(id),
            "ERC1155: caller is not the token adapter"
        );
        _transferFrom(operator, from, to, id, amount, data);
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(ERC1155, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
