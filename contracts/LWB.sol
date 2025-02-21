// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";

contract LWB {
    string public name = "LWB";
    string public symbol = "LWB";

    
    uint256 public decimals = 18;
    uint256 public totalSupply;

    using SafeMath for uint256; //1为了uint256后面使用 sub ，add方法

    mapping(address =>uint256) public blanceOf;
    constructor() {
        totalSupply = 1000000 * (10 ** decimals);
        //创始人有最多的代币
        blanceOf[msg.sender] = totalSupply;
    }

    function tansfer(address _to, unit256 _value) public return(bool success){
        blanceOf[msg.sender] = blanceOf[msg.sender].sub(_valee);
        blanceOf[_to] = blanceOf[msg.sender].add(_value);
    }

    // struct Student {
    //     uint id;
    //     string name;
    //     uint age;
    //     address account;
    // }

    // //动态数组
    // Student[] public studentList;

    // function addList(string memory _name, uint _age) public returns (uint) {
    //     uint count = studentList.length;
    //     uint id = count + 1;
    //     studentList.push(Student(id, _name, _age, msg.sender));
    //     return studentList.length;
    // }

    // //view 视图函数，只访问不修改状态, pure 纯函数，不访问也不修改
    // function getDate() public view returns (Student[] memory) {
    //     return studentList;
    // }
}
