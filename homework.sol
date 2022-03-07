pragma solidity >=0.7.0 <0.8.0;
pragma experimental ABIEncoderV2;

contract MarketplaceContract
    struct Item {
        uint item_id;
        string name;
        address payable owner;
        bool item_exists;
    }
    enum SaleStates {
        OnSale,
        Sold,
        Cancelled
    }
    struct Sale {
        uint sale_id;
        uint item_id;
        uint price;
        SaleStates state;
        address seller;
        address buyer;
        bool sale_exists;
    }
    mapping (uint => Item) idToItem;
    mapping (uint => Sale) idToSale;

    uint idCounter = 0;

    function incrementIdCounter () returns (uint) {
        idCounter++;
        return idCounter;
    }

    function getItem(uint _item_id) public view returns (Item memory){
        require (idToItem[_item_id].item_exists, "Item does not exist");
        return idToItem[_item_id];
    }

    function getSale(uint _sale_id) public view returns (Sale memory){
        require (idToSale[_sale_id]).sale_exists, "Sale does not exist");
        return idToSale[_sale_id];
    }

    function newItem (string _name) public {
        uint id = incrementIdCounter();
        Item memory newItemRequest = Item(
            id,
            _name,
            msg.sender,
            true
        );
        idToItem[id]= newItemRequest;
    }

    function newSale (uint _item_id) public {
        uint id = incrementIdCounter();
        Sale memory newSaleRequest = Sale(
            id,
            _item_id,
            0,
            OnSale,
            0,
            0,
            true
        )
        idToSale[id] = newSaleRequest;
    }

    function buyItem (uint _sale_id) public payable isOnSale{

    }

    modifier isOnSale(uint _sale_id) {
        require(idToSale[_sale_id].state == OnSale, "The item is not on sale !");
        _;
    }
