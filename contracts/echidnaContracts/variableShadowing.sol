contract TokenSale{
	int variable;

	function update1(int _a) public{
		variable = _a;
	}

	function returnVar1() public returns(int){
		return variable;
	}
}


contract PreSale is TokenSale{
	int variable;


	function update2(int _a) public{
		variable = _a;
	}

	function returnVar2() public returns(int){
		return variable;
	}
}


contract Test{
	bool flag=true;
	PreSale P = new PreSale();

	function set0(int val) public{
		P.update2(val);
	}

	function echidna_shouldBeAlwaysTrue() public returns(bool){
		flag = (P.returnVar1() == P.returnVar2());
		return !flag;
	}
}
