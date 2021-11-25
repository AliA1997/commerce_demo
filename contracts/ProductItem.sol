// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

import "./Product.sol";

contract ProductItem {
    Product parentContract;
    uint public pricePaid;
    uint public index;
    Product.ProductItemStatus public status;

    constructor(Product _parentContract, uint _index, Product.ProductItemStatus _status) public {
        parentContract = _parentContract;
        index = _index;
        status = _status;
    }
    event ProductItemStatusChange(uint indexed index, address indexed productAddress, Product.ProductItemStatus status);

    function UpdateStatus(Product.ProductItemStatus _status) public {
        status = _status;
        emit ProductItemStatusChange(index, address(this), status);
    }

    receive() external payable {
        require(pricePaid == 0, "Product is paid already");
        pricePaid += msg.value;
        //The transfer function only can do 23000 gas, but they are cases when more is required such as calling a function in a parentContract
        // address(parentContract).transfer(msg.value)
        //As of version 8(i think) you can set the amount of gas you want to use and value is between curly braces.
        (bool success, ) = address(parentContract).call{value: msg.value, gas: 1000000 }(abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "The transaction wasn't successful.");
    }
}
