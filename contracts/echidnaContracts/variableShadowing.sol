contract Tokensale {
    uint public hardcap = 10000;

    constructor() public{}

    function fetchCap() public constant returns(uint) {
        return hardcap;
    }
}

contract Presale is Tokensale {
    uint public hardcap = 1000;

    constructor() public{}

    function update(uint _a) public{
        hardcap = _a;
   // Tokensale.hardcap = _a + 10;
    }
    
    function echidna_differentHardcaps() public returns (bool) {
        return (hardcap != fetchCap());
    }
     
    
}

