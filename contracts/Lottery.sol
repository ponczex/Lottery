pragma solidity ^0.4.18;

contract Lottery {

    address public manager;
    address[] public players;
    mapping (address => uint) public balances;

    modifier onlyManager {
        require(msg.sender == manager);
        _;
    }

    function Lottery() public payable {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > 0.000001 ether);
        players.push(msg.sender);
        balances[msg.sender] += msg.value;
    }

    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    function random() private view returns (uint){
        return uint(keccak256(block.difficulty, block.timestamp, players));
    }

    function pickWinner() public onlyManager {
        uint winner = random() % players.length;
        players[winner].transfer(this.balance);
        players = new address[](0);
    }

    function getPlayers() public view returns (address[]){
        return players;
    }

}
