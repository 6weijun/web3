const Exchange = artifacts.require("Exchange.sol");

const fromWei = (n) => {
  return web3.utils.fromWei(n, 'ether');
}

const toWei = (n) => {
  return web3.utils.toWei(n.toString(), 'ether');
}
module.exports = async function (callback) {
  const accounts = await web3.eth.getAccounts();
  console.log('accounts[0]', accounts[0])
  const exchange = await Exchange.deployed();

  await exchange.depositEther({
    from: accounts[0],
    value: toWei(10)
  });
  callback();
};