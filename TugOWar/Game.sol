pragma solidity ^0.5.7;

contract Game {

    address a;
    address b;
    int8[] moves;
    address winner;
    mapping(address => int8) participants;

    constructor (address opponent) public {
        a = msg.sender;
        b = opponent;
        participants[msg.sender] = 1;
        participants[opponent] = -1;
        winner = address(0);
    }

    function favored() public view returns(uint8, address) {
        return (0, address(0));
    }

    function hasWinner() public view returns(bool) {
        return winner != address(0);
    }

    function scoreVector() public view returns (int16) {
        int16 score = 0;
        uint8 length = uint8(moves.length);
        for (uint8 key = 0; key < moves.length && key < 256; key += 1) {
            score += moves[key];
        }
        return score;
    }

    function scoreScalar() public view returns(uint8) {
        int16 score = scoreVector();
        return score < 0 ? uint8(score * -1) : uint8(score);
    }

    function computeWinner() public view returns(address) {
        return address(0);
    }

    function amWinner() public view returns (bool) {
        return msg.sender == winner;
    }

    function increment() public returns (bool, address) {
        return push(true);
    }

    function finished() public view returns(bool) {
        return scoreScalar() == uint16(512);
    }

    function push(bool step) public returns(bool, address) {
        if (hasWinner()) {
            return (true, winner);
        }
        int8 affirmative = participants[msg.sender];
        assert(affirmative != 0);
        moves.push(step ? affirmative : (affirmative * -1));
        winner = computeWinner();
        return (hasWinner(), winner);
    }

}
