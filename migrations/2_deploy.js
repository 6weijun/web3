

const contacts = artifacts.require('StudentStorage.sol');

module.exports = function (deployer) {
  deployer.deploy(contacts);
}