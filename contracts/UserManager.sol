// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

//import "openzeppelin-contracts/blob/release-v4.4/contracts/access/Ownable.sol";
import "./User.sol";

contract UserManager {
    enum UserStatus {NotVerified, Verified}

    mapping(uint => UserStruct) public users;
    uint public numberOfUsers;

    struct UserStruct {
        User user;
        UserManager.UserStatus userStatus;
    }

    struct CreateUserOptions {
        string email;
        string password;
        UserManager.UserStatus userStatus;
    }

    constructor() public {}

    event UserStatusChange(uint indexed index, address indexed user, UserManager.UserStatus status);

    function registerUser(CreateUserOptions memory _createUserOptions) public {
        User user = new User(this, _createUserOptions.email, _createUserOptions.password);
        users[numberOfUsers].user = user;
        users[numberOfUsers].userStatus = UserStatus.NotVerified;
        emit UserStatusChange(numberOfUsers, address(users[numberOfUsers].user), UserStatus.NotVerified);
        numberOfUsers++;
    }
}