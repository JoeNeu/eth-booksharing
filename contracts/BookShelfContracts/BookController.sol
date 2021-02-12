// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;


import "../BaseContracts/Mortal.sol";
import "./Interfaces/BookDatabaseInterface.sol";


contract BookController is Mortal {
    BookDatabaseInterface private bookDb;

    constructor(address _bookDb, address _bookEvents) {
        bookDb = BookDatabaseInterface(_bookDb);
    }

    // Delegate Calls

    function keyExists(bytes32 _key) internal view returns (bool) {
        BookDatabaseInterface.Exemplar memory exemplar = bookDb.getExemplar(_key);
        return exemplar.owner != address(0x00);
    }

    function addBook(string calldata _isbn) external {
        bytes32 newKey = keccak256(abi.encode(_isbn, msg.sender, block.timestamp));
        require(!keyExists(newKey), "Hash already exists");

        BookDatabaseInterface.Exemplar memory exemplar = BookDatabaseInterface.Exemplar(
        {
            owner: msg.sender,
            currentHolder: msg.sender,
            requester : address(0x00),
            isUnlocked: true,
            isbn: _isbn,
            price: 0.01 ether
        });
        bookDb.addExemplar(newKey, exemplar);
    }

    function getExemplar(bytes32 _key) external view returns(BookDatabaseInterface.Exemplar memory) {
        return bookDb.getExemplar(_key);
    }

    // Update delegate Calls to Database Contract

    function request(bytes32 _key) payable external returns(bool) {
        BookDatabaseInterface.Exemplar memory exemplar = bookDb.getExemplar(_key);
        require(msg.value == exemplar.price, "price is not equal");
        require(exemplar.state);
        bookDb.updateIsUnlocked(_key, false);
        bookDb.updateRequester{gas: 100000, value: exemplar.price }(_key,msg.sender, exemplar.price);
        return true;
    }

    function approveRequest(bytes32 _key) external returns(bool) {
        BookDatabaseInterface.Exemplar memory exemplar = bookDb.getExemplar(_key);
        require(exemplar.holder == msg.sender);
        bookDb.updateCurrentHolder(_key, exemplar.requester);
        return true;
    }

    function lockExemplar(bytes32 _key) external returns(bool) {
        BookDatabaseInterface.Exemplar memory exemplar = bookDb.getExemplar(_key);
        require(exemplar.holder == msg.sender);
        bookDb.updateIsUnlocked(_key, false);
        return true;
    }

    function unlockExemplar(bytes32 _key) external returns(bool) {
        BookDatabaseInterface.Exemplar memory exemplar = bookDb.getExemplar(_key);
        require(exemplar.holder== msg.sender && exemplar.requester == address(0x00));
        bookDb.updateIsUnlocked(_key, true);
        return true;
    }
}
