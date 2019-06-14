   # fosterfuzz
This is a pre research repository for Summer Research 2019 at IIT Kanpur

### Instructions to setu ECHIDNA
##### [Method 1] Using docker
- Install [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

*It is possible that docker may not work at once. For that you need to install [Docker Compose](https://docs.docker.com/compose/install/)*

- **Run the following command to FUZZ the contract**
Clone Echidna repository -> `https://github.com/crytic/echidna.git` and run the following command inside `echidna`.

```
docker build -t echidna .
```
- Inside echidna run following to fuzz the contract with path `/src/examples/solidity/basic/flags.sol`
```
docker run -t -v `pwd`:/src echidna echidna-test /src/examples/solidity/basic/flags.sol
```
**Note:** *Here pwd is the current directory. `/src/examples/solidity/basic/flags.sol` is the path to the contract from current directory.*

- Running the contract with a *configuration file*
```
docker run -t -v `pwd`:/src echidna echidna-test /src/examples/solidity/basic/balance.sol TEST --config="/src/examples/solidity/basic/balance.yaml"
```
> *TEST* : is the contract you want to FUZZ inside the specified file.

> *balance.yaml* : is the config file. You need to put the complete path of it.


##### [Method 2] Building using source
- Clone the repository `https://github.com/crytic/echidna.git`
- Run `stack install` while inside the repository.

**Note:** This step may require a lot of dependencies to be installed. Some are very hard to debug with no proper solution available online. So it is better to use the Docker image. (*Though Docker images don't carry latest updates in echidna. But should work for most of the contracts implemented right now.*)


---------

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
