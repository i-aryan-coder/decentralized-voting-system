# Voting Contract

This repository contains a simple voting contract written in Solidity. It allows the owner to add candidates and users to vote for them within a specified voting period.

## Solidity Contract

### Structure

- `contracts/`: Contains the Solidity contract.

### Contract Details

- The contract is named `Voting`.
- It allows the owner to initialize candidates and set the voting duration.
- Users can vote for candidates during the active voting period.
- The contract includes functions to add candidates, cast votes, get vote counts, and check the voting status.

### Functions

- `constructor(string[] memory candidateNames, uint256 votingDuration)`: Initializes the contract with candidate names and voting duration.
- `addCandidate(string memory _name)`: Adds a new candidate (owner only).
- `vote(uint256 _candidateIndex)`: Casts a vote for a candidate.
- `getAllVotesPerCandidate()`: Returns the list of candidates and their vote counts.
- `votingStatus()`: Checks if the voting period is currently active.
- `remainingTime()`: Returns the remaining time for voting.

### Setup

1. Install dependencies:

```bash
npm install
npx hardhat compile
npx hardhat test
npx hardhat run scripts/deploy.js
