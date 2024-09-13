// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NftTicket {
    IERC721 public eventNft;
    uint256 public eventCount;

    struct Event {
        uint256 id;
        string name;
        string description;
        string location;
        uint256 date;
        uint256 maxCapacity;
        uint256 registrationDeadline;
        address[] registeredUsers;
    }

    mapping(uint256 => Event) public events;
    mapping(uint256 => mapping(address => bool)) public hasUserRegistered;
    Event[] public eventsArray;

    event EventCreated(uint256 indexed eventId, string name, uint256 date);
    event UserRegistered(uint256 indexed eventId, address indexed user);

    constructor(address _eventNft) {
        eventNft = IERC721(_eventNft);
    }

    function createEvent(
        string memory _name,
        string memory _description,
        uint256 _date,
        string memory _location,
        uint256 _maxCapacity,
        uint256 _registrationDeadline
    ) external {
        require(bytes(_name).length > 0, "Event name cannot be empty");
        require(
            bytes(_description).length > 0,
            "Event description cannot be empty"
        );
        require(bytes(_location).length > 0, "Event location cannot be empty");
        require(_date > 0, "Event date must be in the future");
        require(
            _registrationDeadline < _date,
            "Registration deadline must be before event date"
        );
        require(_maxCapacity > 0, "Max capacity must be greater than zero");
        require(
            eventCount < type(uint256).max,
            "Maximum number of events reached"
        );

        uint256 _newEventId = eventCount + 1;

        Event storage _event = events[_newEventId];
        _event.id = _newEventId;
        _event.name = _name;
        _event.description = _description;
        _event.location = _location;
        _event.date = _date * (block.timestamp + 60);
        _event.maxCapacity = _maxCapacity;
        _event.registrationDeadline =
            _registrationDeadline *
            (block.timestamp + 60);

        eventsArray.push(_event);

        eventCount = eventCount + 1;

        emit EventCreated(_newEventId, _name, _date);
    }

    function registerForEvent(uint256 _eventId) external {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        require(
            !hasUserRegistered[_eventId][msg.sender],
            "User already registered for this event"
        );

        Event storage _event = events[_eventId];

        require(
            _event.registeredUsers.length < _event.maxCapacity,
            "Event is full"
        );
        require(
            block.timestamp < _event.registrationDeadline,
            "Registration period has ended"
        );
        require(block.timestamp < _event.date, "Event has already occurred");
        require(
            eventNft.balanceOf(msg.sender) > 0,
            "Must own an Nft to register"
        );

        _event.registeredUsers.push(msg.sender);
        hasUserRegistered[_eventId][msg.sender] = true;

        emit UserRegistered(_eventId, msg.sender);
    }

    function getAllEvents() external view returns (Event[] memory) {
        return eventsArray;
    }

    function viewEvent(uint256 _eventId) external view returns (Event memory) {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        return events[_eventId];
    }

    function checkRegistrationValidity(
        uint256 _eventId,
        address _userAddress
    ) external view returns (bool) {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        return hasUserRegistered[_eventId][_userAddress];
    }
}
