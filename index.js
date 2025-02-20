import addContent from './add-content.js';
import { version, exchanges } from 'ccxt';
import Web3 from 'web3';
import abi from './build/contracts/StudentStorage.json';

var web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");

import './style.css';

document.write('<p>hello body!!!</p>');
addContent();


const showBalance = async (key) => {
  const balance = await web3.eth.getBalance(key);
  const balanceTowei = web3.utils.fromWei(balance, 'ether');
  console.log('balance', balanceTowei);
}

async function init() {
  // const num = await web3.eth.getBlockNumber();
  // const chinId = await web3.eth.getChainId();
  // const idkey = await web3.eth.requestAccounts();
  // console.log('idkey', idkey);

  showBalance('0x70997970C51812dc3A010C7d01b50e0d17dc79C8');

  // await web3.eth.sendTransaction({
  //   from: '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  //   to: '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  //   value: web3.utils.toWei(1, 'ether')
  // })
  showBalance('0x70997970C51812dc3A010C7d01b50e0d17dc79C8');

  //连接合约
  const contact_address = '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512';
  const studentStorage = new web3.eth.Contract(abi.abi, contact_address);

  const getList = async function () {
    const studentList = await studentStorage.methods.getDate().call();
    console.log('studentStorage2:', studentList);
  }
  const kk = meg.sender();
  debugger;
  getList()
  const data = await studentStorage.methods.addList('luqiushi', 39).send({
    from: '0x70997970C51812dc3A010C7d01b50e0d17dc79C8'
  });
  console.log('studentStorage', data);
  getList()
}

init();

// console.log(version, Object.keys(exchanges));