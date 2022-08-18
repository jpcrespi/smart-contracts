/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../extensions/ERC1155Supply.sol";
import "../control/ERC1155MintableControl.sol";
import "../control/ERC1155BurnableControl.sol";
import "../control/ERC1155PausableControl.sol";
import "../control/ERC1155URIStorageControl.sol";

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
contract ERC1155PresetControl is
    ERC1155MintableControl,
    ERC1155BurnableControl,
    ERC1155PausableControl,
    ERC1155URIStorageControl,
    ERC1155Supply
{
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(
            ERC1155,
            ERC1155MintableControl,
            ERC1155BurnableControl,
            ERC1155PausableControl,
            ERC1155URIStorageControl
        )
        returns (bool success)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 tokenId)
        public
        view
        virtual
        override(ERC1155Supply, ERC1155URIStorage)
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
        override(ERC1155, ERC1155Pausable, ERC1155Supply, ERC1155URIStorage)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
