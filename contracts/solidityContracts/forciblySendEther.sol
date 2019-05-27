pragma solidity>=0.4.24;   

contract IwillNotTakeAnyEther{
    address owner;
    
    function() public payable{
        revert();
    }
    
    function balance() public returns(uint256){
        return address(this).balance;
    }
}

contract heyThereTakeSomeEther { 
    function Deposit() payable {}
    
    function noMatterWhatIwillGiveYouEther(address a) public payable{
        selfdestruct(a);
    }
    
    function sendEther(address _a) public payable{
        _a.transfer(msg.value);
    }
    
    function balance() public returns(uint256){
        return address(this).balance;
    }
}
