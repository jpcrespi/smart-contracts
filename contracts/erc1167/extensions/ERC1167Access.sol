/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-1167

pragma solidity ^0.8.0;

import "../ERC1167.sol";
import "../../access/Controllable.sol";
import "../../access/roles/EditRole.sol";

/**
 *
 */
abstract contract ERC1167Access is Controllable, EditRole, ERC1167 {
    /**
     *
     */
    function deploy(address implementation)
        public
        virtual
        returns (address instance)
    {
        require(
            IAccessControl(_controller).hasRole(EDITOR_ROLE, _msgSender()),
            "ERC20Burnable: sender does not have role"
        );
        return _deploy(implementation);
    }
}
