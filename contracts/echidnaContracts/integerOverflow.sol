contract Test {
    
    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public lastBalanceOf;
    address a; 

	function set(uint val) public{
		if(val % 10 == 0)	buy(val);
	}

    function buy(uint256 numTokens) public payable {
        a = msg.sender;
        lastBalanceOf[a] = balanceOf[a];
        balanceOf[a] += numTokens;
    }
    
    function echidna_testOverflow() public returns(bool){
        if(lastBalanceOf[a] > balanceOf[a])
            return true;
    }
}
