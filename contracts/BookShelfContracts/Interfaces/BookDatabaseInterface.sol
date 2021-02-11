// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

interface BookDatabaseInterface {

    struct Exemplar{
        address Owner;
        address currentHolder;
        address requester;
        bool isUnlocked;
        string isbn;
        uint price;
      }

}
