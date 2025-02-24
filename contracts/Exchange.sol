// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./LWB.sol";

contract Exchange {
    using SafeMath for uint256; //为了uint256后面使用 sub ，add方法
    address public feeAccount;
    uint256 feePercent;
    address constant ETHER = address(0);
    uint256 public orderCount;

    mapping(address => mapping(address => uint256)) public tokens;
    //订单结构体
    struct _Order {
        uint256 id;
        address user;
        address tokenGet;
        uint256 amountGet;
        address tokenGive;
        uint256 amountGive;
        uint256 timestamp;
    }
    mapping(uint256 => _Order) public orders;
    mapping(uint256 => bool) public orderCancel;

    event Deposit(address token, address user, uint256 amount, uint256 balance);
    event WithDraw(
        address token,
        address user,
        uint256 amount,
        uint256 balance
    );
    event Order(
        uint256 id,
        address user,
        address tokenGet,
        uint256 amountGet,
        address tokenGive,
        uint256 amountGive,
        uint256 timestamp
    );
    event cancelOrder(
        uint256 id,
        address user,
        address tokenGet,
        uint256 amountGet,
        address tokenGive,
        uint256 amountGive,
        uint256 timestamp
    );
    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }
    function depositEther() public payable {
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].add(msg.value);
        emit Deposit(ETHER, msg.sender, msg.value, tokens[ETHER][msg.sender]);
    }
    function withdrawEther(uint256 _account) public {
        //余额必须大于acount
        require(tokens[ETHER][msg.sender] >= _account);
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].sub(_account);
        payable(msg.sender).transfer(_account);
        emit WithDraw(ETHER, msg.sender, _account, tokens[ETHER][msg.sender]);
    }

    function depositLWB(address _token, uint256 _value) public {
        require(_token != ETHER);
        require(LWB(_token).transferFrom(msg.sender, address(this), _value));
        tokens[_token][msg.sender] = tokens[_token][msg.sender].add(_value);
        emit Deposit(_token, msg.sender, _value, tokens[_token][msg.sender]);
    }

    function withDrawLwb(address _token, uint256 _account) public {
        require(_token != ETHER);
        require(tokens[_token][msg.sender] >= _account);

        tokens[_token][msg.sender] = tokens[_token][msg.sender].sub(_account);
        require(LWB(_token).transfer(msg.sender, _account));
        emit WithDraw(_token, msg.sender, _account, tokens[_token][msg.sender]);
    }

    function blanceOf(
        address _token,
        address _user
    ) public view returns (uint256) {
        return tokens[_token][_user];
    }

    function makeOder(
        address _tokenGet,
        uint256 _amountGet,
        address _tokenGive,
        uint256 _acmountGive
    ) public {
        orderCount = orderCount.add(1);
        orders[orderCount] = _Order(
            orderCount,
            msg.sender,
            _tokenGet,
            _amountGet,
            _tokenGive,
            _acmountGive,
            block.timestamp
        );
        emit Order(
            orderCount,
            msg.sender,
            _tokenGet,
            _amountGet,
            _tokenGive,
            _acmountGive,
            block.timestamp
        );
    }
    function cancelOder(uint256 _id) public {
        _Order memory myorder = orders[_id];
        require(myorder.id == _id);
        orderCancel[_id] = true;

        emit cancelOrder(
            myorder.id,
            msg.sender,
            myorder.tokenGet,
            myorder.amountGet,
            myorder.tokenGive,
            myorder.amountGive,
            block.timestamp
        );
    }
}
