pragma solidity>=0.4.24;

// This contract performs the unchecked send.
// Since, send() does not return any exception when not successful. The balance won't detect from the vulnerable
// contract, when send()ing the funds to the attacker contract. | When the attacker's fallback function have 
// computationally heavy function

// While in the case of attacker contract not having any computationally heavy function, the send()ing of funds 
// should work.


contract vulnerable{
    uint256 defaultAmount = 1 ether;
    address payable public nominee ;
    mapping (address => uint256) balance;
    uint256 _amount;

    function() external payable{
        
    }
    
    function addNominee(address payable _nominee) public {
        nominee =_nominee;
    }
    
    // function add(uint256 _amountToBeAdded){
    //     balance[msg.sender] += 
    // }
    
    function deposit() payable public{
        address(this).transfer(_amount);
    }
    
    function transact() public{
        nominee.send(defaultAmount);
    }
    
    function getTargetBalance() public view returns(uint256){
        return address(this).balance;
    }
}

contract attacker{
    
    bool private flag;
    vulnerable v = vulnerable(0xef55BfAc4228981E850936AAf042951F7b146e41);
    uint256 _amount = 3 ether;
    
    constructor() public{
        flag = false;
    }
    
    function deposit(address payable _addr) payable public{
        _addr.transfer(_amount);
    }
    
    function() external payable{
        if(!flag){
            // then do some computationally heavy stuff
            // address(v).transfer(_amount/1000);
        }
        else{
            // Do some computationally lighter stuff
        }
    }
    
    function getTargetBalance() public view returns(uint256){
        return address(this).balance;
    }
    
}

// contract echidna{
    
// }
