// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.4/contracts/access/Ownable.sol";
import "./Product.sol";
import "./ProductItem.sol";

contract ProductManager {
    enum ProductStatus {InStock,OutOfStock,ComingSoon}
    enum ProductCategories {Home,BedandBath,Games,ComputerAndTablets,ComputerAccessories,TVs,Phones,MensClothing,WomensClothing}

    struct ProductStruct {
        Product product;
        ProductManager.ProductCategories productCategory;
        ProductManager.ProductStatus productStatus;
    }

    struct CreateProductOption {
        uint priceInWei;
        string name;
        uint quantity;
        ProductManager.ProductCategories category;
    }

    mapping(uint => ProductStruct) public products;
    uint public numberOfProducts;
    uint public paymentsReceived;

    event ProductStatusChange(uint indexed index, address indexed productAddress, ProductManager.ProductStatus productStatus);

    function createProduct(CreateProductOption memory newProduct) public {
        Product product = new Product(numberOfProducts, newProduct.priceInWei, newProduct.name, newProduct.quantity);
        product.initializeProductItems();
        products[numberOfProducts].product = product;
        products[numberOfProducts].productCategory = newProduct.category;
        products[numberOfProducts].productStatus = ProductStatus.InStock;
        emit ProductStatusChange(numberOfProducts, address(products[numberOfProducts].product), ProductStatus.InStock);
        numberOfProducts++;
    }

    function createProductComingSoon(CreateProductOption memory newProduct) public {
        Product product = new Product(numberOfProducts, newProduct.priceInWei, newProduct.name, newProduct.quantity);
        products[numberOfProducts].product = product;
        products[numberOfProducts].productCategory = newProduct.category;
        products[numberOfProducts].productStatus = ProductStatus.ComingSoon;
        emit ProductStatusChange(numberOfProducts, address(products[numberOfProducts].product), ProductStatus.ComingSoon);
        numberOfProducts++;
    }

    receive() external payable {
        paymentsReceived += msg.value;
    }

}