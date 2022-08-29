/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/roles/HoldRole.sol";
import "../../access/Controllable.sol";
import "../holder/ERC1155Holder.sol";

/**
 *
 */
abstract contract ERC1155HolderAccess is Controllable, HoldRole, ERC1155Holder {
    /**
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function setERC1155Access(address erc1155) public virtual {
        require(
            IAccessControl(_controller).hasRole(HOLDER_ROLE, _msgSender()),
            "ERC1155: sender does not have role"
        );
        _setApprovalForAll(erc1155, _msgSender(), true);
    }
}
