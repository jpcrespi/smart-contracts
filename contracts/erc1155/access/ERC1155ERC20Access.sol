/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/roles/EditRole.sol";
import "../../access/Controllable.sol";
import "../extensions/ERC1155ERC20.sol";

/**
 *
 */
abstract contract ERC1155ERC20Access is Controllable, EditRole, ERC1155ERC20 {
    /**
     *
     */
    function setERC20Adapter(uint256 tokenId, address tokenAdapter)
        public
        virtual
    {
        require(
            IAccessControl(_controller).hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: caller is not the token adapter"
        );
        _setERC20Adapter(tokenId, tokenAdapter);
    }
}
