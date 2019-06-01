
contract a{
    uint256 _amount = 1 ether;
    
    constructor() public payable{
        
    }
    
    function retBal() public returns(uint256){
        return address(this).balance;
    }
    
    function transact(address _a) public{
        _a.call.value(_amount)();
    }
}

contract b{
    
//    uint256 _am = 0 ether;
    a _theContract = new a();
	bool flag = false;
    
    function() public payable{
		if(flag)					anotherTransfer();
    }
    
	function set0(int val, int val2) public{
    		if (val % 10 == 0 && (val2 % 5) >= 3) 	flag=true;
  	}

	function anotherTransfer() public returns(uint256){
        _theContract.transact(address(this));
    }

	function echidna_shouldFailWhenBalIsZero() public returns(bool){
		if(address(_theContract).balance > 0)			return true;
		else									return false;
	}
       
}



