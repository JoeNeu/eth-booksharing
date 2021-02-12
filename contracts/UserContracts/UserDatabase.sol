// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;
import "../BaseContracts/Accessible.sol";

contract UserDatabase is Accessible {

    mapping(address => string) private addressToName;
    mapping(string => address) private nameToAddress;

    // Setters

    function addUser(address _userAddress, string calldata _username) onlyAccessor() external {
        nameToAddress[_username] = _userAddress;
        addressToName[_userAddress] = _username;
    }

    function removeUser(address _userAddress) onlyAccessor() external {
        delete nameToAddress[addressToName[_userAddress]];
        delete addressToName[_userAddress];
    }

    // Getters

    function getUserName(address _address) external view returns (string memory) {
        return addressToName[_address];
    }

    function getUserAddress(string calldata _username) external view returns (address) {
        return nameToAddress[_username];
    }
}
