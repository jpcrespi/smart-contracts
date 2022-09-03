/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/IAccessControl.sol";
import "../../access/extensions/HoldAccess.sol";
import "../../access/Controllable.sol";
import "../holder/ERC1155Holder.sol";

/**
 *
 */
abstract contract ERC1155HolderAccess is HoldAccess, ERC1155Holder {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, ERC1155Holder)
        returns (bool success)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function setERC1155Access(address erc1155) public virtual {
        require(
            hasRole(HOLDER_ROLE, _msgSender()),
            "ERC1155: caller is not the token adapter"
        );
        _setApprovalForAll(erc1155, _msgSender(), true);
    }
}
