/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../access/ERC1155ERC20Access.sol";
import "../access/ERC1155MintableAccess.sol";
import "../access/ERC1155BurnableAccess.sol";
import "../access/ERC1155PausableAccess.sol";
import "../access/ERC1155URIStorageAccess.sol";

/**
 * @dev {ERC1155} token, including:
 *
 *  - ability for holders to burn (destroy) their tokens
 *  - a minter role that allows for token minting (creation)
 *  - a pauser role that allows to stop all token transfers
 *
 * This contract uses {AccessControl} to lock permissioned functions using the
 * different roles - head to its documentation for details.
 *
 * The account that deploys the contract will be granted the minter and pauser
 * roles, as well as the default admin role, which will let it grant both minter
 * and pauser roles to other accounts.
 *
 * _Deprecated in favor of https://wizard.openzeppelin.com/[Contracts Wizard]._
 */
contract ERC1155ERC20PresetAccess is
    ERC1155MintableAccess,
    ERC1155BurnableAccess,
    ERC1155PausableAccess,
    ERC1155URIStorageAccess,
    ERC1155ERC20Access
{
    /**
     *
     */
    constructor(address controller_) Controllable(controller_) {}

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId)
        public
        view
        virtual
        override(ERC1155ERC20, ERC1155URIStorage)
        returns (bool)
    {
        return ERC1155URIStorage.exists(tokenId);
    }

    /**
     *
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    )
        internal
        virtual
        override(ERC1155, ERC1155Pausable, ERC1155URIStorage, ERC1155ERC20)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
