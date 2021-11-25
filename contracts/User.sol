// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

//import "openzeppelin-contracts/blob/release-v4.4/contracts/access/Ownable.sol";
import "./UserManager.sol";

contract User {
    UserManager public parentContract;
    string public email;
    string private password;

    constructor(UserManager _parentContract, string memory _email, string memory _password) public {
        parentContract = _parentContract;
        email = _email;
        password = _password;
    }
}