// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

import './Mortal.sol';

contract Accessible is Mortal {
    address public _accessor;

    modifier onlyAccessor() {
        require(msg.sender == _accessor,"Sender is not the Accessor");
        _;
    }

    function setAccessor(address accessor) external onlyOwner() {
        _accessor = accessor;
    }
}
