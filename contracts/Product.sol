// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

import "./ProductItem.sol";

contract Product {
    enum ProductItemStatus {NotPaid,Paid,Shipped,Delivered}
    
    struct ProductItemStruct {
        ProductItem productItem;
        string name;
    }

    uint public index;
    uint public priceInWei;
    string public name;
    uint public quantity;
    mapping(uint => ProductItemStruct) public productItems;

    constructor(uint _index, uint _priceInWei, string memory _name, uint _quantity) public {
        index = _index;
        priceInWei = _priceInWei;
        name = _name;
        quantity = _quantity;
    }

    function initializeProductItems() public {
        uint productItemIndex = 0;
        while(productItemIndex < quantity) {
            ProductItem productItem = new ProductItem(this, productItemIndex, ProductItemStatus.NotPaid);
            productItems[productItemIndex].productItem = productItem;
            productItems[productItemIndex].name = name;
            productItemIndex++;
        }
    }


    function triggerPayment(uint _index) public payable {
        productItems[_index].productItem.UpdateStatus(ProductItemStatus.Paid);
        quantity--;
    }

    function triggerShipped(uint _index) public payable {
        productItems[_index].productItem.UpdateStatus(ProductItemStatus.Shipped);
    }
}