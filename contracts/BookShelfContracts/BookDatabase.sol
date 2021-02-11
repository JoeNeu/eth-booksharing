// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract BookDatabase {

    struct Exemplar {
        address owner;
        address currentHolder;
        address requester;
        bool isUnlocked;
        string isbn;
        uint price;
    }

}
