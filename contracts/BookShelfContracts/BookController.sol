// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

import "./Interfaces/BookDatabaseInterface.sol";


contract BookController  {
    BookDatabaseInterface private bookDb;

    constructor(address _bookDb, address _bookEvents) {
        bookDb = BookDatabaseInterface(_bookDb);
    }
}
