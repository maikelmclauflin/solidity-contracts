pragma solidity ^0.5.7;
import "./Game.sol";

contract TugOWar is Game {
    uint8 line;

    constructor(uint8 _line, address challenger) Game(challenger) public {
        line = _line;
    }

    function decrement() public returns (bool, address) {
        return super.push(false);
    }

    function finished(uint8 absolute) public view returns (bool) {
        return absolute == line;
    }

    function favored() public view returns (uint8, address) {
        address nullAddress = address(0);
        if (winner != nullAddress) {
            return (0, winner);
        }
        int16 score = scoreVector();
        if (score > 0) {
            return (line - uint8(score), a);
        }
        if (score < 0) {
            return (uint8(int16(line) + score), b);
        }
        return (line, address(0));
    }

    function computeWinner() public view returns (address) {
        address sender = msg.sender;
        if (moves.length == 0) {
            return address(0);
        }
        int16 last = int16(moves.length) - 1;
        int16 lastMove = moves[uint8(last)];
        int16 score = scoreVector();
        uint8 absolute = score < 0 ? uint8(score * -1) : uint8(score);
        if (score > 0 && finished(absolute)) {
            return lastMove == 1 && sender == a ? a : b;
        } else if (score < 0 && finished(absolute)) {
            return lastMove == -1 && sender == b ? b : a;
        } else {
            return address(0);
        }
    }
}
