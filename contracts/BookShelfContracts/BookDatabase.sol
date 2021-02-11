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

    bytes32[] keyCollection;

    mapping(bytes32 => Exemplar) private keyToExemplars;


    // Setters

    function addExemplar(string calldata _isbn, bytes32 _key, address _owner, address _currentHolder, address _requester) external {
        keyCollection.push(_key);
        keyToExemplars[_key] = Exemplar({
        owner:_owner,
        currentHolder: _currentHolder,
        requester : _requester,
        isUnlocked: true,
        isbn: _isbn,
        price: 0.01 ether
        });
    }

    // Update

    function updateRequester(bytes32 _key, address _requester, uint price) payable external {
        keyToExemplars[_key].requester = _requester;
    }

    function updateCurrentHolder(bytes32 _key, address _currentHolder) external {
        uint refund = (keyToExemplars[_key].price * 10) / 9;
        payable(address(keyToExemplars[_key].currentHolder)).transfer(refund);
        keyToExemplars[_key].price = refund;
        keyToExemplars[_key].currentHolder = _currentHolder;
    }

    function updateIsUnlocked(bytes32 _key, bool _isUnlocked) external {
        keyToExemplars[_key].isUnlocked = _isUnlocked;
    }

    // Getters

    function getExemplar(bytes32 _key) external view returns(address owner, address holder, address requester, bool state, string memory isbn, uint price) {
        return (keyToExemplars[_key].owner,keyToExemplars[_key].currentHolder, keyToExemplars[_key].requester, keyToExemplars[_key].isUnlocked, keyToExemplars[_key].isbn, keyToExemplars[_key].price);
    }

    function getKeyCollection() external view returns(bytes32[] memory) {
        return keyCollection;
    }
}
