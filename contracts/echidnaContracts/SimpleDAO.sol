contract SimpleDAO {
    mapping (address => uint) public credit;
    
    function() public payable{
        
    }
    
    function deposit(uint256 _amount) payable public{
        credit[msg.sender] += _amount;
    }
        
    function withdraw(uint amount) public{
        if (credit[msg.sender]>= amount) {
          (msg.sender.call.value(amount)());
          credit[msg.sender]-=amount;
        }
    }  
    
    function queryCredit(address to) view public returns(uint){
        return credit[to];
    }
        
    function retbalance() public returns(uint256 _A){
        return address(this).balance;
    }
    
}
