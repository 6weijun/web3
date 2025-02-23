
const contacts = artifacts.require('LWB.sol');

module.exports = async function (deployer) {
  await deployer.deploy(contacts);
}