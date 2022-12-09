// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

    contract item_manager
    {
     enum supplychainsteps{created,paid,delivered}

     struct s_item{
        uint priceinwei;
        item_manager.supplychainsteps _step;
        string item_name;
        bool paid;
     }
     mapping(uint => s_item) public items;

    uint public index;
    

    event supplychainstep(uint index, uint _step);
    
    function create_item(string memory _name,uint _priceinwei) public 
    {   items[index].priceinwei=_priceinwei;
        items[index]._step=supplychainsteps.created;
        items[index].item_name=_name;
        emit supplychainstep(index, uint(items[index]._step));
        index++;
    }
    function triggerpayment(uint _index)public payable
    {   require(items[_index]._step==supplychainsteps.created,"Item not yet created");
        require(msg.value == items[_index].priceinwei,"Not enough ether");
        items[_index].paid=true;
        items[_index]._step=supplychainsteps.paid;
        emit supplychainstep(_index,uint(items[_index]._step));
    }
        function triggerdelivery(uint _index) public 
        {
        require(items[_index]._step==supplychainsteps.paid,"PAYMENT NOT DONE");
        items[_index]._step=supplychainsteps.delivered;
        emit supplychainstep(_index,uint(items[_index]._step));

    }
    }
 