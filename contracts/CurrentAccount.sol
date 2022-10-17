//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract CurrentAccount {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        mapping(uint => Transaction) deposits;
        uint numWithdrawals;
        mapping(uint => Transaction) withdrawals;
    }

    mapping(address => Balance) public balanceReceived;

    modifier minWithdraw {
        require(balanceReceived[msg.sender].totalBalance>= 5000 wei,"Your balance is not 5000 wei");
        _;
    }
    modifier minValue {
        require(msg.value>= 5000 wei, "Your deposit balance is less than 5000 wei");
        _;
    }

    //Will show balance of your address(account)
    function getBalance(address _addr) public view returns(uint) {
        return balanceReceived[_addr].totalBalance;
    }
     
     //deposit amount in your account and transaction detail
    function depositMoney() public payable  minValue{
        balanceReceived[msg.sender].totalBalance += msg.value;
        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balanceReceived[msg.sender].deposits[balanceReceived[msg.sender].numDeposits] = deposit;
        balanceReceived[msg.sender].numDeposits++;
    }

    //withdraw amount from your account
    function withdrawMoney(address payable _to, uint _amount) public payable minWithdraw {
        balanceReceived[msg.sender].totalBalance -= _amount; 
        Transaction memory withdrawal = Transaction(msg.value, block.timestamp);
        balanceReceived[msg.sender].withdrawals[balanceReceived[msg.sender].numWithdrawals] = withdrawal;
        balanceReceived[msg.sender].numWithdrawals++;
        _to.transfer(_amount);
    }
}
