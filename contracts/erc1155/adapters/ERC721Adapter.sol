// /// SPDX-License-Identifier: MIT
// /// @author: Juan Pablo Crespi

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../../../interfaces/erc1155/IERC1155ERC721.sol";
import "../../../interfaces/erc721/IERC721.sol";
import "../../../interfaces/erc721/IERC721Metadata.sol";
import "../../../interfaces/erc721/IERC721TokenReceiver.sol";

/**
 *
 */
contract ERC721Adapter is Context, ERC165, IERC721, IERC721Metadata {
    using Address for address;
    using Strings for uint256;
    //
    string internal _name;
    string internal _symbol;
    //
    address internal _erc1155;
    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    /**
     *
     */
    constructor(
        address erc1155_,
        string memory name_,
        string memory symbol_
    ) {
        _erc1155 = erc1155_;
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     *
     */
    function name() public view override returns (string memory) {
        return _name;
    }

    /**
     *
     */
    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    /**
     *
     */
    function tokenURI(uint256 id) public view override returns (string memory) {
        return IERC1155ERC721(_erc1155).uri(id);
    }

    /**
     * @dev See {IERC721-balanceOf}
     */
    function balanceOf(address owner) public view override returns (uint256) {
        return IERC1155ERC721(_erc1155).balanceOf(owner);
    }

    /**
     * @dev See {IERC721-ownerOf}
     */
    function ownerOf(uint256 tokenId) public view override returns (address) {
        return IERC1155ERC721(_erc1155).ownerOf(tokenId);
    }

    /**
     * @dev See {IERC721-transferFrom}
     */
    function transferFrom(
        address from,
        address to,
        uint256 id
    ) public virtual override {
        address operator = _msgSender();
        require(
            _isApprovedOrOwner(operator, id),
            "ERC721: transfer caller is not owner nor approved"
        );

        _transfer(operator, from, to, id, "");
    }

    /**
     * @dev See {IERC721-safeTransferFrom}
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id
    ) public virtual override {
        address operator = _msgSender();
        require(
            _isApprovedOrOwner(operator, id),
            "ERC721: transfer caller is not owner nor approved"
        );
        _safeTransfer(operator, from, to, id, "");
    }

    /**
     * @dev See {IERC721-safeTransferFrom}
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        bytes calldata data
    ) public virtual override {
        address operator = _msgSender();
        require(
            _isApprovedOrOwner(operator, id),
            "ERC721: transfer caller is not owner nor approved"
        );
        _safeTransfer(operator, from, to, id, data);
    }

    /**
     * @dev See {IERC721-approve}
     */
    function approve(address to, uint256 id) public override {
        address operator = _msgSender();
        require(to != ownerOf(id), "ERC721: approval to current owner");

        require(
            _isApprovedOrOwner(operator, id),
            "ERC721: approve caller is not owner nor approved for all"
        );
        _approve(to, id);
    }

    /**
     * @dev See {IERC721-setApprovalForAll}

     */
    function setApprovalForAll(address operator, bool approved)
        public
        override
    {
        _setApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC721-getApproved}

     */
    function getApproved(uint256 id)
        public
        view
        override
        returns (address operator)
    {
        require(_exists(id), "ERC721: approved query for nonexistent token");
        return _tokenApprovals[id];
    }

    /**
     * @dev See {IERC721-isApprovedForAll}
     */
    function isApprovedForAll(address owner, address operator)
        public
        view
        override
        returns (bool)
    {
        return IERC1155ERC721(_erc1155).isApprovedForAll(owner, operator);
    }

    /**
     * @dev Returns whether `id` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     */
    function _exists(uint256 id) internal view virtual returns (bool) {
        return IERC1155ERC721(_erc1155).exists(id);
    }

    /**
     * @dev Returns whether `spender` is allowed to manage `id`.
     *
     * Requirements:
     *
     * - `id` must exist.
     */
    function _isApprovedOrOwner(address spender, uint256 id)
        internal
        view
        virtual
        returns (bool)
    {
        require(_exists(id), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(id);
        return (spender == owner ||
            isApprovedForAll(owner, spender) ||
            getApproved(id) == spender);
    }

    /**
     * @dev Approve `operator` to operate on all of `owner` tokens
     *
     * Emits a {ApprovalForAll} event.
     */
    function _setApprovalForAll(
        address owner,
        address operator,
        bool approved
    ) internal virtual {
        require(owner != operator, "ERC721: approve to caller");
        IERC1155ERC721(_erc1155).erc721SetApprovalForAll(
            owner,
            operator,
            approved
        );
        emit ApprovalForAll(owner, operator, approved);
    }

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * `_data` is additional data, it has no specified format and it is sent in call to `to`.
     *
     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.
     * implement alternative mechanisms to perform token transfer, such as signature-based.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `id` token must exist and be owned by `from`.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeTransfer(
        address operator,
        address from,
        address to,
        uint256 id,
        bytes memory data
    ) internal virtual {
        _transfer(operator, from, to, id, data);
        _doSafeTransferAcceptanceCheck(operator, from, to, id, data);
    }

    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     *
     * Emits a {Transfer} event.
     */
    function _transfer(
        address operator,
        address from,
        address to,
        uint256 id,
        bytes memory data
    ) internal virtual {
        IERC1155ERC721(_erc1155).erc721TransferFrom(
            operator,
            from,
            to,
            id,
            1,
            data
        );
        emit Transfer(from, to, id);
    }

    /**
     * @dev Approve `to` to operate on `tokenId`
     *
     * Emits a {Approval} event.
     */
    function _approve(address to, uint256 id) internal virtual {
        _tokenApprovals[id] = to;
        emit Approval(ownerOf(id), to, id);
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param id uint256 ID of the token to be transferred
     * @param data bytes optional data to send along with the call
     */
    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        bytes memory data
    ) internal {
        if (to.isContract()) {
            bytes4 response = IERC721TokenReceiver(to).onERC721Received(
                operator,
                from,
                id,
                data
            );
            require(
                response == IERC721TokenReceiver.onERC721Received.selector,
                "ERC721: transfer to non ERC721Receiver implementer"
            );
        }
    }
}
