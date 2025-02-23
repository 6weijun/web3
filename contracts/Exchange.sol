// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import './LWB.sol';

contract Exchange {
    using SafeMath for uint256; //为了uint256后面使用 sub ，add方法

    address public feeAccount;
    uint256 feePercent;

    address constant ETHER = address(0);

    mapping(address => mapping(address => uint256)) public tokens;

    event Deposit(address token, address user, uint256 amount, uint256 balance);

    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }
    function depositEther() payable public{
      tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].add(msg.value);
      emit Deposit(ETHER, msg.sender, msg.value, tokens[ETHER][msg.sender]);
    }

    function depositLWB(address _token, uint256 _value) public{
      require(_token != ETHER);
      require(LWB(_token).transferFrom(msg.sender, address(this), _value));
      tokens[_token][msg.sender] = tokens[_token][msg.sender].add(_value);
      emit Deposit(_token, msg.sender, _value, tokens[_token][msg.sender]);
    }
} 
