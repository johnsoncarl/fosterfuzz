contract Test {
	bool flag;	
	address[] listAddresses;

	constructor() public{
		flag = true;    
	}
    

     function ifillArray() public {
        if(listAddresses.length<1500) {

            for(uint i=0;i<500;i++) {
                listAddresses.push(msg.sender);
            }
			flag = false;

        } else {
            listAddresses = new address[](0);
			flag = true;            
        }
    }

	function echidna_mustFail() public view returns (bool){
		return flag;
	}
}

