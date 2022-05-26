/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "../../../interfaces/erc20/IERC20Metadata.sol";
import "../ERC777Metadata.sol";

/**
 * @dev Implementation of the {IERC777} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * Support for ERC20 is included in this contract, as specified by the EIP: both
 * the ERC777 and ERC20 interfaces can be safely used when interacting with it.
 * Both {IERC777-Sent} and {IERC20-Transfer} events are emitted on token
 * movements.
 *
 * Additionally, the {IERC777-granularity} value is hard-coded to `1`, meaning that there
 * are no special restrictions in the amount of tokens that created, moved, or
 * destroyed. This makes integration with ERC20 applications seamless.
 */
contract ERC777ERC20Metadata is ERC777Metadata, IERC20Metadata {
    // ERC20-allowances
    mapping(address => mapping(address => uint256)) private _allowances;

    /**
     * @dev `defaultOperators` may be an empty array.
     */
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 granularity_
    ) ERC777Metadata(name_, symbol_, granularity_) {
        // register interfaces
        _ERC1820_REGISTRY.setInterfaceImplementer(
            address(this),
            keccak256("ERC20Token"),
            address(this)
        );
    }

    /**
     * @dev See {IERC20Metadata-name}.
     */
    function name()
        public
        view
        virtual
        override(ERC777Metadata, IERC20Metadata)
        returns (string memory)
    {
        return super.name();
    }

    /**
     * @dev See {IERC777-symbol}.
     */
    function symbol()
        public
        view
        virtual
        override(ERC777Metadata, IERC20Metadata)
        returns (string memory)
    {
        return super.symbol();
    }

    /**
     * @dev See {ERC20-decimals}.
     *
     * Always returns 18, as per the
     * [ERC777 EIP](https://eips.ethereum.org/EIPS/eip-777#backward-compatibility).
     */
    function decimals() public pure virtual override returns (uint8) {
        return 18;
    }
}
