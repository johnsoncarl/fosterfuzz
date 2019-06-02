## Descriptions
Following are the bugs to be tested with their respective SWC registries.
*[Marked are working with echidna]*
- [ ] delegatecall (the proxy calls) *(SWC-112)* (Inclusion of Functionality from Untrusted Control Sphere)
- [x] DoS With Block Gas Limit *(SWC - 128)*
- [ ] Integer Overflow *(SWC - 101)*
- [ ] Reentrancy Bug(DAO attack) *(Improper Enforcement of Behavioral Workflow) (SWC-107)*
- [x] uncheckedSend() *(SWC - 113)*
- [ ] tx.origin bug 
- [ ] Variable Shadowing *(SWC-119)*

#### 1. dos_gas.sol()
DOS with Block Gas limit is A denial of service attack, where a host contract denies to perform its duties due to limited amount of gas provided for each transaction (*about 3 million*). 
```
    for(uint i=0;i<500;i++) {
        listAddresses.push(msg.sender);
    }
```
Here to make the contract to always true change the upper bound of `i` to some lesser value, say `i<100`. Increase the value to fail it at a certain point.

#### 2. uncheckedSend()
Whenever a contract, say *sender*, transfers the *ether* to another contract,say *receiver*, the *payable* function of the *receiver* is triggered, and this can be misused. For eg. `payable` function of the *receiver* contains some computationally heavy instructions, it can cause `transfer() to fail` and `send() function to return false`. Thus if the `send()` is not checked, it may cause a bug called `uncheckedSend`.

Also, since `send()` doesn't propogate the exception, its harmful of the users to use it. 
```
contract attacker{
    bool public flag=false;
    
    function change() public{
		if(!flag) 	flag=true;	
		else    	flag=false;
	}

	function() external payable {if(flag)	revert();}
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
```
Here, `echidna_send()` will be the main function whose `bool` value will be checked by the tool. 

- `payable functions` : payable functions are necessary for the contract to accept the *ether*. Whenever a contract, say *sender*, transfers the *ether* to another contract,say *receiver*, the *payable* function of the *receiver* is triggered.
- `echidna_send()` : contains `address(this).transfer(msg.value);` which is responsible for transferring ether to the `Test` contract. Which will then be transferred to the the instance of the contract attacker, `a`. 
        *Note: we are transferring 0 ethers to the contract address and then to the instance `a`. As `address.send()` doesn't revert state whenever the payment fails. So we try to return its bool value, which is then catched by `echidna_send()`, and thus by the tool. This is the value that the tool mainly checks for, and thus will be able to tell whether the contract payment through send was completed or not.* 

-  `set0(int val)` : random value is provided to `set0(int val)` as argument. Which then waits for the no. satisfy the condition `if (val % 10 == 0)`. As soon as this value is catched, it triggeres `change()` function of the contract.
-   `change()` : This is responsible for flipping the `flag` value. So as soon as this function is triggered, `flag=false` changes to `true`, and now revert state in the `payable` will be activated. Now, the `contract attacker`, will be reverting each transaction made to it. 

**So this is how it works:** [*a* is the instance if *contract attacker*]
We first start running the contract with `a.flag == false`, and wait for a value in `set(int val)`, to flip the flag of `contract a` to `true`, and thus activating the revert in `payable`. This will fail everytime the payment is made. And since, the `send()` doesn't revery any exception, it shall revert true of false. Which is catched by `echidna_send()`, and will be returned to the tool, to state that the payment could not be completed.

[View this thread for more about address.send and address.transfer](https://github.com/ethereum/solidity/issues/610)
