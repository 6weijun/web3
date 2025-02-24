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

  //eth withdraw
  // await exchange.withdrawEther(toWei(1),{
  //   from: accounts[0],
  // });
  const res = await exchange.tokens(ETHER_ADDRESS, accounts[0]);
  console.log('提取5 eth之后还剩', fromWei(res)); 

  await exchange.withDrawLwb(lwb.address, toWei(5000), {
    from: accounts[0]
  })
  const res1 = await exchange.tokens(lwb.address, accounts[0]);
  console.log('提取5000lwb之后还剩', fromWei(res1));
  callback();
};