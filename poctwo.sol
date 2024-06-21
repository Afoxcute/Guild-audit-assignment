pragma solidity ^0.8.0;

contract Raffle {
    address payable public winner;
    mapping(address => uint) public entries;

    function enterRaffle() public payable {
        entries[msg.sender] += msg.value;
    }

    function selectWinner() public {
        winner = payable(randomAddress()); // Vulnerable function (replace with secure randomness)
        // Rest of winner selection logic
    }

    function refund() public {
        if (msg.sender != winner) {
            payable(msg.sender).transfer(entries[msg.sender]);
            entries[msg.sender] = 0;
        }
    }

    function randomAddress() private view returns (address) {
        // This is for demonstration purposes only. Replace with a secure random number generator.
        return keccak256(abi.encodePacked(blockhash(block.number - 1), msg.sender));
    }
}
