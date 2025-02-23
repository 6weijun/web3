

const contacts = artifacts.require('StudentStorage.sol');

module.exports = async function (deployer) {
  await deployer.deploy(contacts);
}