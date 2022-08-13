// SPDX-License-Identifier: MIT
// Author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/bep20/IBEP20.sol";
import "../ERC20.sol";
import "../../security/Controllable.sol";

/**
 *
 */
abstract contract BEP20 is ERC20, Controllable, IBEP20 {
    /**
     * @dev Returns the bep20 token owner which is necessary for binding with bep2 token.
     *
     * NOTE - This is an extended method of EIP20.
     * Tokens which don’t implement this method will never
     * flow across the Binance Chain and Binance Smart Chain.
     */
    function getOwner() external view override returns (address) {
        return controller();
    }
}
