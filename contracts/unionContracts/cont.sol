pragma solidity>=0.4.24;

import "./SampleERC20.sol" ;
import "./SampleERC20sec.sol";

contract cont{
    fuzz1Token F1H;
    fuzz2Token F2H;
    
    mapping (address => bool) public superUser;
    
    constructor() public{
        F1H = new fuzz1Token();
        F2H = new fuzz2Token();
        superUser[msg.sender] = true;
        superUser[address(this)] = true;
    }
    
    //  --------------------This contract specific functions---------------------------------------------
    function addToSuperUser(address _a) public{
        require(superUser[msg.sender]);
        superUser[_a] = true;
    }
    //  --------------------This contract specific functions ends---------------------------------------------
    
    
    // ---------------------FuzzToken1 wrapper functions---------------------------------------------
    function wrapper_F1_totalSupply() public constant returns (uint) { return F1H.totalSupply();}
    function wrapper_F1_balanceOf(address tokenOwner) public constant returns (uint balance) {return F1H.balanceOf(tokenOwner); }
    function wrapper_F1_transfer(address to, uint tokens) public returns (bool success) {
        // require(superUser[msg.sender]);
        return F1H.transfer(to, tokens); 
        
    }
    function wrapper_F1_approve(address spender, uint tokens) public returns (bool success) {  return F1H.approve(spender, tokens); }
    function wrapper_F1_transferFrom(address from, address to, uint tokens) public returns (bool success) {return F1H.transferFrom(from, to, tokens);  }
    function wrapper_F1_allowance(address tokenOwner, address spender) public constant returns (uint remaining) { return F1H.allowance(tokenOwner, spender);}
    function wrapper_F1_approveAndCall(address spender, uint tokens, bytes data) public returns (bool success) {return F1H.approveAndCall(spender, tokens, data); }
    
    function wrapper_F1_transferOwnership(address _a) public{
        require(superUser[msg.sender]);
        F1H.transferOwnership(_a);
    }
    
    function wrapper_F1_acceptOwnershipByOtherUser() public {
       require(superUser[msg.sender]);
       F1H.acceptOwnership();
    }
    // ---------------------FuzzToken1 wrapper functions ends---------------------------------------------
    
    //  ---------------------FuzzToken2 wrapper functions---------------------------------------------
    function wrapper_F2_totalSupply() public constant returns (uint) { return F2H.totalSupply();}
    function wrapper_F2_balanceOf(address tokenOwner) public constant returns (uint balance) {return F2H.balanceOf(tokenOwner); }
    function wrapper_F2_transfer(address to, uint tokens) public returns (bool success) { 
        require(superUser[msg.sender]);
        return F2H.transfer(to, tokens); 
    }
    function wrapper_F2_transferPersonal(address to, uint tokens) public returns (bool success) { 
        require(superUser[tx.origin]);
        return F2H.transfer(to, tokens); 
    }
    function wrapper_F2_approve(address spender, uint tokens) public returns (bool success) {  return F2H.approve(spender, tokens); }
    function wrapper_F2_transferFrom(address from, address to, uint tokens) public returns (bool success) {return F2H.transferFrom(from, to, tokens);  }
    function wrapper_F2_allowance(address tokenOwner, address spender) public constant returns (uint remaining) { return F2H.allowance(tokenOwner, spender);}
    function wrapper_F2_approveAndCall(address spender, uint tokens, bytes data) public returns (bool success) {return F2H.approveAndCall(spender, tokens, data); }
    
    function wrapper_F2_transferOwnership(address _a) public{
        require(superUser[msg.sender]);
        F2H.transferOwnership(_a);
    }
    
    function wrapper_F2_acceptOwnershipByOtherUser() public {
       require(superUser[msg.sender]);
       F2H.acceptOwnership();
    }
    //  ---------------------FuzzToken2 wrapper functions ends---------------------------------------------

    
    // ---------------------Special functions---------------------------------------------
    function() public payable{}

    function retOnwer() public view returns(address _A){
        return (F1H.returnOwner());
    }
    
    function retOnwer2() public view returns(address _B){
        return (F2H.returnOwner());
    }
    // ---------------------Special functions ends---------------------------------------------
    
    
}
