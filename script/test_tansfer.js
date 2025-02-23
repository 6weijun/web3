const LWB = artifacts.require("LWB.sol");

const fromWei = (n)=>{
  return web3.utils.fromWei(n,'ether');
}

const toWei = (n)=>{
  return web3.utils.toWei(n.toString(),'ether');
}
module.exports = async function (callback) {
  const _lwb = await LWB.deployed();
 
  const blance = await _lwb.blanceOf('0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266');
  console.log('_lwb', fromWei(blance));

  // await _lwb.transfer("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", toWei(1000));

  console.log('_lwb', fromWei(blance));
  callback();
};