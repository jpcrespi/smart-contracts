// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../erc1155/extensions/ERC1155Burnable.sol";

/**
 *
 */
contract ERC1155BurnableMock is ERC1155Burnable {
    /**
     *
     */
    function burn(
        address account,
        uint256 id,
        uint256 value
    ) public virtual {
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burn(account, id, value);
    }

    /**
     *
     */
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values
    ) public virtual {
        require(
            _isOwnerOrApproved(account),
            "ERC1155: caller is not owner nor approved"
        );

        _burnBatch(account, ids, values);
    }
}
