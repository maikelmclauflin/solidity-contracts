pragma solidity ^0.5.7;

contract SimpleStorage {
    uint storedData;

    function set(uint x) public returns (uint) {
        storedData = x;
        return storedData;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}
