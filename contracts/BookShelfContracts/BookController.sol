// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

import "./Interfaces/BookDatabaseInterface.sol";


contract BookController  {
    BookDatabaseInterface private bookDb;

    constructor(address _bookDb, address _bookEvents) {
        bookDb = BookDatabaseInterface(_bookDb);
    }

    // Delegate Calls

    function keyExists(bytes32 _key) internal view returns (bool){
        address owner;
        (owner,,,,,)=bookDb.getExemplar(_key);
        return owner != address(0x00);
    }

    function addBook(string calldata _isbn) external returns(bool){
        bytes32 newKey = keccak256(abi.encode(_isbn, msg.sender, block.timestamp));
        require(!keyExists(newKey), "Hash already exists");

        bookDb.addExemplar(_isbn, newKey, msg.sender, msg.sender, address(0x00));
        return true;
    }

    function getExemplar(bytes32 _key) external view returns(address, address, address, bool, string memory, uint) {
        return bookDb.getExemplar(_key);
    }

    // Update delegate Calls to Database Contract

    function request(bytes32 _key) payable external returns(bool) {
        address holder;
        bool state;
        uint price;
        (,holder,,state,,price) = bookDb.getExemplar(_key);
        require(msg.value == price, "price is not equal");
        require(state);
        bookDb.updateIsUnlocked(_key, false);
        bookDb.updateRequester{gas: 100000, value: price }(_key,msg.sender, price);
        return true;
    }

    function approveRequest(bytes32 _key) external returns(bool) {
        address requester;
        address holder;
        (,holder,requester,,,) = bookDb.getExemplar(_key);
        require(holder == msg.sender);
        bookDb.updateCurrentHolder(_key, requester);
        return true;
    }

    function lockExemplar(bytes32 _key) external returns(bool) {
        address holder;
        (,holder,,,,) = bookDb.getExemplar(_key);
        require(holder == msg.sender);
        bookDb.updateIsUnlocked(_key,false);
        return true;
    }

    function unlockExemplar(bytes32 _key) external returns(bool) {
        address holder;
        address requester;
        (,holder,requester,,,) = bookDb.getExemplar(_key);
        require(holder== msg.sender && requester == address(0x00));
        bookDb.updateIsUnlocked(_key,true);
        return true;
    }
}
