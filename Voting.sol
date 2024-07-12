pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint votecount;
    }

    Candidate[] public candidates;
    address public owner;
    mapping(address => bool) public voters;
    uint256 public votingStart;
    uint256 public votingEnd;

    constructor(string[] memory candidateNames, uint256 votingDuration) {
        require(candidateNames.length > 0, "No candidate names provided");
        require(votingDuration > 0, "Voting duration must be greater than 0");

        for (uint256 i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                votecount: 0
            }));
        }
        owner = msg.sender;
        votingStart = block.timestamp;
        votingEnd = block.timestamp + votingDuration * 1 minutes;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate({
            name: _name,
            votecount: 0
        }));
    }

    function vote(uint256 _candidateIndex) public {
        require(block.timestamp >= votingStart && block.timestamp < votingEnd, "Voting is not active");
        require(!voters[msg.sender], "You have already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate index");

        candidates[_candidateIndex].votecount++;
        voters[msg.sender] = true;
    }

    function getAllVotesPerCandidate() public view returns (Candidate[] memory) {
        return candidates;
    }

    function votingStatus() public view returns (bool) {
        return (block.timestamp >= votingStart && block.timestamp < votingEnd);
    }

    function remainingTime() public view returns (uint256) {
        require(block.timestamp > votingStart, "Voting has not started yet");
        if (block.timestamp >= votingEnd) {
            return 0;
        }
        return votingEnd - block.timestamp;
    }
}
