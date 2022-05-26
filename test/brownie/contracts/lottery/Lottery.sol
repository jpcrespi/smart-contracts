// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract Lottery is VRFConsumerBase, Ownable {
    event RequestedRandomness(bytes32 requestId);
    enum State {
        open,
        close,
        calculating
    }
    address payable[] private _players;
    uint256 private _entraceFee;
    uint256 private _fee;
    bytes32 private _keyHash;
    address payable private _winner;
    uint256 private _randomness;
    AggregatorV3Interface private _priceFeed;
    State private _state;

    constructor(
        address priceFeed_,
        address vrfConsumer_,
        address link_,
        uint256 fee_,
        bytes32 keyHash_
    ) VRFConsumerBase(vrfConsumer_, link_) {
        _entraceFee = 50 * 10**18;
        _priceFeed = AggregatorV3Interface(priceFeed_);
        _state = State.close;
        _fee = fee_;
        _keyHash = keyHash_;
    }

    modifier open() {
        require(_state == State.open);
        _;
    }

    modifier close() {
        require(_state == State.close);
        _;
    }

    modifier calculating() {
        require(_state == State.calculating);
        _;
    }

    function enter() public payable open {
        require(msg.value >= getEntranceFee(), "Not enough ETH!");
        _players.push(payable(msg.sender));
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , ) = _priceFeed.latestRoundData();
        uint256 adjustedPrice = uint256(price * 10**10);
        return (_entraceFee * 10**18) / adjustedPrice;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return _players[index];
    }

    function getState() public view returns (State) {
        return _state;
    }

    function lastWinner() public view returns (address) {
        return _winner;
    }

    function lastRandomness() public view returns (uint256) {
        return _randomness;
    }

    function start() public close onlyOwner {
        _state = State.open;
    }

    function end() public onlyOwner {
        _state = State.calculating;
        bytes32 requestId = requestRandomness(_keyHash, _fee);
        emit RequestedRandomness(requestId);
    }

    function fulfillRandomness(bytes32, uint256 randomness_)
        internal
        override
        calculating
    {
        require(randomness_ > 0);
        uint256 index = randomness_ % _players.length;
        _winner = _players[index];
        _winner.transfer(address(this).balance);
        _randomness = randomness_;
        _players = new address payable[](0);
        _state = State.close;
    }
}
