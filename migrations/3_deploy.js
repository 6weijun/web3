const exchange = artifacts.require('Exchange.sol');

module.exports = async function (deployer) {
  const accounts = await web3.eth.getAccounts();
  await deployer.deploy(exchange, accounts[0], 10);
}