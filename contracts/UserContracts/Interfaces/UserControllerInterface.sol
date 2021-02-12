// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

interface UserControllerInterface {
    function getUserName(address  _address) external  view returns (string memory);

    function getUserAddress(string calldata _username) external view returns (address);

    function isRegisteredUser(address entityAddress) external view returns (bool);

    function isRegisteredUser() external view returns (bool);
}
