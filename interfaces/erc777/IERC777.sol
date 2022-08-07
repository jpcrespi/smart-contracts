/// SPDX-License-Identifier: MIT
/// @author: Juan Pablo Crespi
/// @dev: https://eips.ethereum.org/EIPS/eip-777
/// @title ERC-777: Token Standard.

pragma solidity ^0.8.0;

interface IERC777 {
    /**
     * @dev Indicates the authorization of operator as an operator for holder.
     * Note: This event MUST NOT be emitted outside of an operator authorization process.
     * parameters
     * @param operator: Address which became an operator of holder.
     * @param holder: Address of a holder which authorized the operator address as an operator.
     */
    event AuthorizedOperator(address indexed operator, address indexed holder);

    /**
     * @dev Indicates the revocation of operator as an operator for holder.
     * Note: This event MUST NOT be emitted outside of an operator revocation process.
     * parameters
     * @param operator: Address which was revoked as an operator of holder.
     * @param holder: Address of a holder which revoked the operator address as an operator.
     */
    event RevokedOperator(address indexed operator, address indexed holder);

    /**
     * @dev Indicate a send of amount of tokens from the from address to the to address
     * by the operator address.
     * Note: This event MUST NOT be emitted outside of a send or an ERC-20 transfer process.
     * parameters
     * @param operator: Address which triggered the send.
     * @param from: Holder whose tokens were sent.
     * @param to: Recipient of the tokens.
     * @param amount: Number of tokens sent.
     * @param data: Information provided by the holder.
     * @param operatorData: Information provided by the operator.
     */
    event Sent(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 amount,
        bytes data,
        bytes operatorData
    );

    /**
     * @dev Indicate the minting of amount of tokens to the to address by the operator address.
     * Note: This event MUST NOT be emitted outside of a mint process.
     * parameters
     * @param operator: Address which triggered the mint.
     * @param to: Recipient of the tokens.
     * @param amount: Number of tokens minted.
     * @param data: Information provided for the recipient.
     * @param operatorData: Information provided by the operator.
     */
    event Minted(
        address indexed operator,
        address indexed to,
        uint256 amount,
        bytes data,
        bytes operatorData
    );

    /**
     * @dev Indicate the burning of amount of tokens from the from address by the operator address.
     * Note: This event MUST NOT be emitted outside of a burn process.
     * parameters
     * @param operator: Address which triggered the burn.
     * @param from: Holder whose tokens were burned.
     * @param amount: Number of tokens burned.
     * @param data: Information provided by the holder.
     * @param operatorData: Information provided by the operator.
     */
    event Burned(
        address indexed operator,
        address indexed from,
        uint256 amount,
        bytes data,
        bytes operatorData
    );

    /**
     * @dev Get the total number of minted tokens.
     * Note: The total supply MUST be equal to the sum of the balances of all
     * addresses—as returned by the balanceOf function.
     * Note: The total supply MUST be equal to the sum of all the minted tokens
     * as defined in all the Minted events minus the sum of all the burned tokens
     * as defined in all the Burned events.
     * identifier: 18160ddd
     * @return totalSupply of tokens currently in circulation.
     */
    function totalSupply() external view returns (uint256 totalSupply);

    /**
     * @dev Get the balance of the account with address holder.
     * Note: The balance MUST be zero (0) or higher.
     * identifier: 70a08231
     * parameters
     * @param holder Address for which the balance is returned.
     * @return balance Amount of tokens held by holder in the token contract.
     */
    function balanceOf(address holder) external view returns (uint256 balance);

    /**
     * @dev Get the list of default operators as defined by the token contract.
     * Note: If the token contract does not have any default operators,
     * this function MUST return an empty list.
     * identifier: 06e48538
     * @return operators List of addresses of all the default operators.
     */
    function defaultOperators()
        external
        view
        returns (address[] memory operators);

    /**
     * @dev Indicate whether the operator address is an operator of the holder address.
     * Note: To know which addresses are operators for a given holder, one MUST call isOperatorFor
     * with the holder for each default operator and parse the AuthorizedOperator, and RevokedOperator
     * events for the holder in question.
     * identifier: d95b6371
     * parameters
     * @param operator: Address which may be an operator of holder.
     * @param holder: Address of a holder which may have the operator address as an operator.
     * @return success true if operator is an operator of holder and false otherwise.
     */
    function isOperatorFor(address operator, address holder)
        external
        view
        returns (bool success);

    /**
     * @dev Set a third party operator address as an operator of msg.sender to send and burn
     * tokens on its behalf.
     * Note: The holder (msg.sender) is always an operator for itself. This right SHALL NOT
     * be revoked. Hence this function MUST revert if it is called to authorize the holder (msg.sender)
     * as an operator for itself (i.e. if operator is equal to msg.sender).
     * identifier: 959b8c3f
     * parameters
     * @param operator: Address to set as an operator for msg.sender.
     */
    function authorizeOperator(address operator) external;

    /**
     * @dev Remove the right of the operator address to be an operator for msg.sender and to send
     * and burn tokens on its behalf.
     * Note: The holder (msg.sender) is always an operator for itself. This right SHALL NOT be revoked.
     * Hence this function MUST revert if it is called to revoke the holder (msg.sender) as an operator
     * for itself (i.e., if operator is equal to msg.sender).
     * identifier: fad8b32a
     * parameters
     * @param operator: Address to rescind as an operator for msg.sender.
     */
    function revokeOperator(address operator) external;

    /**
     * @dev Send the amount of tokens from the address msg.sender to the address to.
     * Note: The operator and the holder MUST both be the msg.sender.
     * identifier: 9bd9bbc6
     * parameters
     * @param to: Recipient of the tokens.
     * @param amount: Number of tokens to send.
     * @param data: Information provided by the holder.
     */
    function send(
        address to,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev Send the amount of tokens on behalf of the address from to the address to.
     * Reminder: If the operator address is not an authorized operator of the from address,
     * then the send process MUST revert.
     * Note: from and msg.sender MAY be the same address. I.e., an address MAY call operatorSend
     * for itself. This call MUST be equivalent to send with the addition that the operator MAY
     * specify an explicit value for operatorData (which cannot be done with the send function).
     * identifier: 62ad1b83
     * parameters
     * @param from: Holder whose tokens are being sent.
     * @param to: Recipient of the tokens.
     * @param amount: Number of tokens to send.
     * @param data: Information provided by the holder.
     * @param operatorData: Information provided by the operator.
     */
    function operatorSend(
        address from,
        address to,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;

    /**
     * @dev Burn the amount of tokens from the address msg.sender.
     * Note: The operator and the holder MUST both be the msg.sender.
     * identifier: fe9d9303
     * parameters
     * @param amount: Number of tokens to burn.
     * @param data: Information provided by the holder.
     */
    function burn(uint256 amount, bytes calldata data) external;

    /**
     * @dev Burn the amount of tokens on behalf of the address from.
     * Reminder: If the operator address is not an authorized operator of the from address,
     * then the burn process MUST revert.
     * identifier: fc673c4f
     * parameters
     * @param from: Holder whose tokens will be burned.
     * @param amount: Number of tokens to burn.
     * @param data: Information provided by the holder.
     * @param operatorData: Information provided by the operator.
     */
    function operatorBurn(
        address from,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;
}
