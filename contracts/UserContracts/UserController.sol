// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

import "./Interfaces/UserDatabaseInterface.sol";

contract UserController {

    UserDatabaseInterface private userDb;

    constructor(address _userdb) {
      userDb = UserDatabaseInterface(_userdb);
    }
}
