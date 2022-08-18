/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../extensions/ERC1155ERC20.sol";
import "../../access/roles/EditRole.sol";

/**
 *
 */
abstract contract ERC1155ERC20Control is EditRole, ERC1155ERC20 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControlEnumerable, ERC1155)
        returns (bool success)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     *
     */
    function setERC20Adapter(uint256 tokenId, address tokenAdapter)
        public
        virtual
    {
        require(
            hasRole(EDITOR_ROLE, _msgSender()),
            "ERC1155: caller is not the token adapter"
        );
        _setERC20Adapter(tokenId, tokenAdapter);
    }
}
