// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;
import "../BaseContracts/Accessible.sol";
import "./Interfaces/BookDatabaseInterface.sol";

contract BookDatabase is Accessible, BookDatabaseInterface {

    bytes32[] keyCollection;

    mapping(bytes32 => Exemplar) private keyToExemplars;


    // Setters

    function addExemplar(bytes32 _key, Exemplar calldata exemplar) override external onlyAccessor() {
        keyCollection.push(_key);
        keyToExemplars[_key] = exemplar;
    }

    // Update

    function updateRequester(bytes32 _key, address _requester) override payable external onlyAccessor() {
        keyToExemplars[_key].requester = _requester;
    }

    function updateCurrentHolder(bytes32 _key, address _currentHolder) override external onlyAccessor() {
        uint refund = (keyToExemplars[_key].price * 10) / 9;
        payable(address(keyToExemplars[_key].currentHolder)).transfer(refund);
        keyToExemplars[_key].price = refund;
        keyToExemplars[_key].currentHolder = _currentHolder;
    }

    function updateIsUnlocked(bytes32 _key, bool _isUnlocked) override external onlyAccessor() {
        keyToExemplars[_key].isUnlocked = _isUnlocked;
    }

    // Getters

    function getExemplar(bytes32 _key) override external view returns(Exemplar memory) {
        return keyToExemplars[_key];
    }

    function getKeyCollection() external view returns(bytes32[] memory) {
        return keyCollection;
    }
}
