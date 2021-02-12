// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

abstract contract BookDatabaseInterface {

    struct Exemplar {
        address owner;
        address currentHolder;
        address requester;
        bool isUnlocked;
        string isbn;
        uint price;
      }

    function addExemplar(bytes32 _key, Exemplar calldata exemplar) virtual external;

    function updateRequester(bytes32 _key, address _requester, uint price) virtual payable external;
    function updateCurrentHolder(bytes32 _key, address _currentHolder) virtual external;
    function updateIsUnlocked(bytes32 _key, bool _isFree) virtual external;

    function getExemplar(bytes32 _key) virtual external view returns(Exemplar memory);
}
