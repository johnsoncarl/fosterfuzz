pragma solidity>=0.4.19;

contract normal{
    uint256 a;
    
    mapping (address => uint256) something;
    
    constructor(uint256 b) public{
        a = b;
    }
    
    function statechange() public {
    	require(a >= 5);
    	a = a*5;
    }

    function value() public view returns (uint256 _a) {
        return a;
    }
}