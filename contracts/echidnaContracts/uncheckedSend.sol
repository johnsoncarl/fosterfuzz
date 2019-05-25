contract attacker{
	bool public flag=false;

	function change() public{
		if(!flag) 	flag=true;	
		else    	flag=false;
	}

	function() external payable {
		if(flag)	revert();
	}
}

contract Test{
	
 	attacker a = new attacker();
	bool private flag0 = true;
	bool private status;
    
	function set0(int val) public returns (bool){
    		if (val % 10 == 0) {a.change();}
    		else flag0=false;
  	}

    function echidna_send() public payable returns(bool){
			address(this).transfer(msg.value);
            return address(a).send(0);
		}

	function() external payable{}
}


