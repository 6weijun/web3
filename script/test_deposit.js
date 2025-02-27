const Exchange = artifacts.require("Exchange.sol");
const Contacts = artifacts.require('LWB.sol');

const ETHER_ADDRESS = "0x0000000000000000000000000000000000000000";
const fromWei = (n) => {
  return web3.utils.fromWei(n, 'ether');
}

const toWei = (n) => {
  return web3.utils.toWei(n.toString(), 'ether');
}
module.exports = async function (callback) {
  const accounts = await web3.eth.getAccounts();
  
  const lwb = await Contacts.deployed();
  const exchange = await Exchange.deployed();

  //eth充值
  await exchange.depositEther({
    from: accounts[0],
    value: toWei(10)
  });
  const res = await exchange.tokens(ETHER_ADDRESS, accounts[0]);
  console.log('eth币数量', fromWei(res));

  //lwb充值
  await lwb.approve(exchange.address, toWei(100000), {
    from: accounts[0]
  });
  await exchange.depositLWB(lwb.address, toWei(100000), {
    from: accounts[0]
  })
  const res1 = await exchange.tokens(lwb.address, accounts[0]);
  console.log('lwb数量', fromWei(res1));
  callback();
};