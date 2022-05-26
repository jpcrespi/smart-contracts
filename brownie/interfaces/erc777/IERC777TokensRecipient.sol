/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-777
/// @title ERC-777: Token Standard.

pragma solidity ^0.8.0;

interface IERC777TokensRecipient {
    /**
     * @dev Notify a send or mint (if from is 0x0) of amount tokens from the from address
     * to the to address by the operator address.
     * Note: This function MUST NOT be called outside of a mint, send or ERC-20 transfer process.
     * identifier: 0023de29
     * parameters
     * @param operator: Address which triggered the balance increase (through sending or minting).
     * @param from: Holder whose tokens were sent (or 0x0 for a mint).
     * @param to: Recipient of the tokens.
     * @param amount: Number of tokens the recipient balance is increased by.
     * @param data: Information provided by the holder.
     * @param operatorData: Information provided by the operator.
     */
    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;
}
