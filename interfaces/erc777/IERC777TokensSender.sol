/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-777
/// @title ERC-777: Token Standard.

pragma solidity ^0.8.0;

interface IERC777TokensSender {
    /**
     * @dev Notify a request to send or burn (if to is 0x0) an amount tokens from the from address
     * to the to address by the operator address.
     * Note: This function MUST NOT be called outside of a burn, send or ERC-20 transfer process.
     * identifier: 75ab9782
     * parameters
     * @param operator: Address which triggered the balance decrease (through sending or burning).
     * @param from: Holder whose tokens were sent.
     * @param to: Recipient of the tokens for a send (or 0x0 for a burn).
     * @param amount: Number of tokens the holder balance is decreased by.
     * @param userData: Information provided by the holder.
     * @param operatorData: Information provided by the operator.
     */
    function tokensToSend(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external;
}
