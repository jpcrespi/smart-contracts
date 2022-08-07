/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-777
/// @title ERC-777: Token Standard.

pragma solidity ^0.8.0;

interface IERC777Metadata {
    /**
     * @dev Get the name of the token
     * identifier: 06fdde03
     * @return name of the token.
     */
    function name() external view returns (string memory name);

    /**
     * Get symbol the symbol of the token
     * identifier: 95d89b41
     * @return symbol of the token.
     */
    function symbol() external view returns (string memory symbol);

    /**
     * @dev Get the smallest part of the token that’s not divisible.
     * In other words, the granularity is the smallest amount of tokens
     * (in the internal denomination) which MAY be minted, sent or burned at any time.
     * The following rules MUST be applied regarding the granularity:
     * - The granularity value MUST be set at creation time
     * - The granularity value MUST NOT be changed, ever.
     * - The granularity value MUST be greater than or equal to 1.
     * - All balances MUST be a multiple of the granularity.
     * - Any amount of tokens (in the internal denomination) minted,
     * sent or burned MUST be a multiple of the granularity value.
     * - Any operation that would result in a balance that’s not a multiple of the
     * granularity value MUST be considered invalid, and the transaction MUST revert.
     * Note: Most tokens SHOULD be fully partition-able. I.e., this function SHOULD r
     * eturn 1 unless there is a good reason for not allowing any fraction of the token.
     * identifier: 556f0dc7
     * @return granularity The smallest non-divisible part of the token.
     */
    function granularity() external view returns (uint256 granularity);
}
