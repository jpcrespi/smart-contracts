pragma solidity ^0.4.26;

contract Lottery {
        
    address private owner;
    address[] private players;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier canPlay() {
        require(msg.value >= 0.01 ether);
        _;
    }

    modifier canRaffle() {
        require(players.length > 0);
        _;
    }

    function enter() public canPlay payable {
        players.push(msg.sender);
    }

    function raffle(string secretWord) public onlyOwner canRaffle {
        uint index = random(secretWord) % players.length;
        players[index].transfer(address(this).balance);
        players = new address[](0);
    }

    function random(string secretWord) private view returns (uint) {
        bytes memory data = abi.encodePacked(secretWord, block.difficulty, now, players);
        return uint(keccak256(data));
    }

    function getPlayers() public view returns (address[]) {
        return players;
    }

        function getOwner() public view returns (address) {
        return owner;
    }

    function getTotal() public view returns (uint) {
        return address(this).balance;
    }
}