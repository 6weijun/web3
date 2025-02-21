

const contacts = artifacts.require('LWB.sol');

module.exports = function (deployer) {
  deployer.deploy(contacts);
}