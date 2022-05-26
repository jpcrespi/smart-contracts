pragma solidity ^0.4.26;

contract Inbox {
    
    string private message;
    
    constructor(string initMessage) public {
        message = initMessage;
    }
    
    function setMessage(string newMessage) public {
        message = newMessage;
    }
    
    function getMessage() public view returns (string) {
        return message;
    }
}