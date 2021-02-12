// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

interface BookDatabaseInterface {

    struct Exemplar{
        address Owner;
        address currentHolder;
        address requester;
        bool isUnlocked;
        string isbn;
        uint price;
      }

    function addExemplar(string calldata _isbn, bytes32 _key, address _owner, address _currentHolder, address _requester) external;

    function updateRequester(bytes32 _key, address _requester, uint price) payable external;
    function updateCurrentHolder(bytes32 _key, address _currentHolder) external;
    function updateIsUnlocked(bytes32 _key, bool _isFree) external;

    function getExemplar(bytes32 _key) external view returns(address owner, address holder,address requester ,bool state, string memory isbn, uint price);
}
