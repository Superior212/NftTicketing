# NFT Ticket Event Registration System

## Overview

This project is a smart contract-based ticketing system built on Ethereum using Solidity. It includes two contracts:

1. **NftTicket**: This contract manages the creation of events and allows users to register for events if they hold a specific ERC721 NFT.
2. **NFT**: This contract mints and manages NFTs, which are used as tickets for registering for events.

Users can register for events as long as they meet the necessary criteria, such as owning the required NFT, and can check their registration status for events.

## Contracts

### 1. `NftTicket.sol`

This contract allows users to create events, register for them, and check the registration status. It interacts with an ERC721 contract (NFT ticket) to ensure users hold the required NFT for registration.

#### Features

- **Event Creation**: Allows users to create events with details such as name, description, location, event date, maximum capacity, and registration deadline.
- **Event Registration**: Users can register for events as long as they hold an NFT ticket and the event is not full or past the registration deadline.
- **Event Details**: View all events or a specific event's details.
- **Check Registration**: Allows users to check if they are registered for a particular event.

#### Main Functions

- **createEvent**: Creates a new event with provided details.
- **registerForEvent**: Registers a user for an event if they hold an NFT and meet the registration conditions.
- **getAllEvents**: Returns a list of all events created.
- **viewEvent**: Returns details of a specific event by ID.
- **checkRegistrationValidity**: Checks if a particular user is registered for an event.

### 2. `NFT.sol`

This contract is responsible for minting the ERC721 NFT used as tickets for the events. Only the owner of the contract can mint new NFTs.

#### Features

- **Mint NFT**: The owner of the contract can mint a new NFT for any recipient, along with a unique metadata URI for that token.

#### Main Functions

- **mintNFT**: Mints a new NFT with the provided token URI and transfers it to the specified recipient.

## Setup and Deployment Instructions

### Prerequisites

- **Node.js** and **npm**: Ensure you have Node.js and npm installed.
- **Hardhat**: Install Hardhat for testing, deploying, and interacting with smart contracts.
- **MetaMask**: For interacting with the smart contract on Ethereum test networks.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Superior212/NftTicketing
   cd NftTicketing
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Compile the contracts:

   ```bash
   npx hardhat compile
   ```

4. Deploy the contracts:

   First, configure your network and private key settings in `hardhat.config.js`.

   Deploy the `NFT.sol` contract:

   ```bash
   npx hardhat run scripts/deploy-nft.js --network <network-name>
   ```

   Deploy the `NftTicket.sol` contract:

   ```bash
   npx hardhat run scripts/deploy-nft-ticket.js --network <network-name>
   ```

5. Run tests:
   ```bash
   npx hardhat test
   ```

### Usage

1. **Mint NFT**: The contract owner can mint an NFT by calling the `mintNFT` function from the NFT contract.
2. **Create Event**: After deploying `NftTicket`, users can call `createEvent` to create events with specified parameters.
3. **Register for Event**: Users holding an NFT can register for events using the `registerForEvent` function. They must provide the event ID and meet all the registration criteria.

4. **Check Event Details**: Call `viewEvent` to get details of a specific event or `getAllEvents` to retrieve all events.

5. **Check Registration Status**: Users can check if they are registered for an event using the `checkRegistrationValidity` function.

### Event Structure

- `id`: Unique ID for the event.
- `name`: Name of the event.
- `description`: Description of the event.
- `location`: Event location.
- `date`: The date when the event takes place.
- `maxCapacity`: Maximum number of users allowed to register.
- `registrationDeadline`: Deadline for registering for the event.
- `registeredUsers`: List of registered users.

### Notes

- Only users holding an NFT (from the `NFT` contract) can register for events.
- Users must register before the registration deadline and only if the event is not full.

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
