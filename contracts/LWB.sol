// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract LWB {
    string public name = "LWB";
    string public symbol = "LWB";

    uint256 public decimals = 18;
    uint256 public totalSupply;

    using SafeMath for uint256; //1为了uint256后面使用 sub ，add方法

    mapping(address => uint256) public blanceOf;
    constructor() {
        totalSupply = 1000000 * (10 ** decimals);
        //创始人有最多的代币
        blanceOf[msg.sender] = totalSupply;
    }

    event Transfer(address indexed _form, address indexed _to, uint256 _value);

    function _transfer(
        address _from,
        address _to,
        uint256 _value
    ) internal {
        require(_to != address(0));
        require(blanceOf[_from] >= _value);
        blanceOf[_from] = blanceOf[_from].sub(_value);
        blanceOf[_to] = blanceOf[_to].add(_value);

        // 触发事件
        emit Transfer(_from, _to, _value);
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_to != address(0));
        _transfer(msg.sender, _to, _value);
        return true;  
    }
}
