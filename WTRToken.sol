pragma solidity ^0.8.4;

contract WTRToken {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    
    uint public totalSupply = 10000 * 10 ** 18;
    string public name = "WTR Finance";
    string public symbol = "WTR";
    uint public decimals = 18;
    
    event Transfer(address indexed sender, address indexed recipient, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
    
    constructor() {
        balances[msg.sender] = totalSupply;
    }
    
    function balanceOf(address account) public view returns(uint) {
        return balances[account];
    }
    
    function transfer(address recipient, uint amount) public returns(bool) {
        require(balanceOf(msg.sender) >= amount, 'ERROR: Balance too low.');
        balances[recipient] = balances[recipient] + amount;
        balances[msg.sender] = balances[msg.sender] - amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    
    function transferFrom(address spender, address recipient, uint amount) public returns(bool) {
        require(balanceOf(spender) >= amount, 'ERROR: Balance too low.');
        require(allowance[spender][msg.sender] >= amount, 'ERROR: Allowance too low.');
        balances[recipient] = balances[recipient] + amount;
        balances[spender] = balances[spender] - amount;
        emit Transfer(spender, recipient, amount);
        return true;
    }
    
    function approve(address spender, uint amount) public returns(bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
}