pragma solidity ^0.5.0;

contract AssociateProfitSplitter {

    // Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`.

    address payable private employee_one;
    address payable private employee_two;
    address payable private employee_three; 
    address payable owner = msg.sender; 

    uimt public balanceContract;

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return balanceContract;
    }

    function deposit() public payable {
        // Split `msg.value` into three

        require (msg.sender == owner, "You are NOT the Owner of this Account");

        uint amount =  msg.value / 3;

        // Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);

        // Take care of a potential remainder by sending back to HR (`msg.sender`)
        owner.transfer(msg.value - amount * 3);
    }

    function() external payable {
        // Enforce that the `deposit` function is called in the fallback function!
        function() deposit;
    }
}
