// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

import "./Interfaces/UserDatabaseInterface.sol";
import "../BaseContracts/Mortal.sol";

contract UserController is Mortal {

    UserDatabaseInterface private userDb;

    constructor(address _userdb) {
      userDb = UserDatabaseInterface(_userdb);
    }

    function register(string calldata _username) external returns(bool) {
        require( bytes(_username).length != 0 , "No Username set");
        if(!_isUsernameAvailable(_username)) {
            return false;
        }
        userDb.addUser(msg.sender, _username);
        return true;
    }

    function isUsernameAvailable(string calldata _username) external view returns (bool) {
       return _isUsernameAvailable(_username);
    }

    function _isUsernameAvailable(string calldata _username) internal view returns (bool) {
       return userDb.getUserAddress(_username) == address(0x00);
    }

    function getUserName(address  _address) external  view returns (string memory){
      return userDb.getUserName(_address);
    }

    function getUserAddress(string calldata _username) external view returns (address){
      return userDb.getUserAddress(_username);
    }

    function login() external view returns (string memory) {
      return userDb.getUserName(msg.sender);
    }

    function isRegisteredUser() external view returns (bool) {
        return bytes(userDb.getUserName(msg.sender)).length != 0;
    }
}
