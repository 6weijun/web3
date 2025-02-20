// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract StudentStorage {
    string name;
    uint age;
    
    function setDate(string memory _name, uint _age) public{
      name = _name;
      age = _age;
    }

    //view 视图函数，只访问不修改状态, pure 纯函数，不访问也不修改
    function getDate() public view returns (string memory, uint){
      return(name, age);
    }
}
