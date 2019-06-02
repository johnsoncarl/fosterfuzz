contract IntegerOverflowMul {
    uint public count = 2;
    uint public lastCount = 0;

    function run(uint input) public {
		lastCount = count;        
		count += (input);
    }
	
	function echidna_test_addOverflow() public returns (bool){
		if(count < lastCount )		return false;
		else 						return true;
	}

}
