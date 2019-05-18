var normal= artifacts.require("./normal.sol");
// var check = artifacts.require("./")

module.exports = function(deployer) {
  deployer.deploy(normal, 5);
  // deployer.deploy()
};
