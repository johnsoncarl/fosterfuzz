   # fosterfuzz
This is a pre research repository for Summer Research 2019 at IIT Kanpur

### Simple steps to follow:

1. Clone and get to the sampleProject directory and execute following
```sh
cd sampleProject && python ../scripts/shell.py
```
The output will be logged to a file ```log.txt``` after each command you execute

### Sample interaction with the contract

1. without transaction
```javascript
normal.deployed().then(function(instance){return instance.value();}).then(function(bal){console.log(bal.toString());})
```
2. with transaction
```javascript
normal.deployed().then(function(instance){instance.statechange(); return instance.value();}).then(function(bal){console.log(bal.toString());})                                        

```

#### contract used
```solidity
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
```

### Dependencies
1. Truffle
2. Python 3
3. python-subprocess
4. python-shlex

[//]:#

[endpoint]: <https://www.endpoint.com/blog/2015/01/28/getting-realtime-output-using-python>
