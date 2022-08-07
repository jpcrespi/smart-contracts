/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-20

pragma solidity ^0.8.0;

/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 */
interface IERC20Metadata {
    /**
     * @return name the name of the token.
     */
    function name() external view returns (string memory name);

    /**
     * @return symbol the symbol of the token, usually a shorter version of the name.
     */
    function symbol() external view returns (string memory symbol);

    /**
     * @return decimals the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * Note: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() external view returns (uint8 decimals);
}
