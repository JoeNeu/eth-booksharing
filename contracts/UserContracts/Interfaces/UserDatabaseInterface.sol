// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

abstract contract UserDatabaseInterface {
  function addUser(address _userAddress, string calldata _username) virtual external;
  function removeUser(address _userAddress) virtual external;
  function getUserName(address _address) virtual external  view returns (string memory);
  function getUserAddress(string calldata _username) virtual external view returns (address);
}
