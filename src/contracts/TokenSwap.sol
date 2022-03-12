// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./SwapTokenA.sol";
import "./SwapTokenB.sol";


contract ParaSwap {
    address payable admin;
    uint256 ratioAB;
    bool isTokenAcheaperThanTokenB;
    uint256 swapFees;


    //IDeclare a type of each of the tokens
    SWAPTOKENA public swapTokenA;
    SWAPTOKENB public swapTokenB;

    constructor(address _swaptokenA, address _swaptokenB) {
        admin = payable(msg.sender);
        swapTokenA = SWAPTOKENA(_swaptokenA);
        swapTokenB = SWAPTOKENB(_swaptokenB);
        swapTokenA.approve(address(this), swapTokenA.totalSupply());
        swapTokenB.approve(address(this), swapTokenB.totalSupply());
    }

    modifier onlyAdmin() {
        payable(msg.sender) == admin;
        _;
    }

    function _multiply(uint256 a, uint256 b) internal pure returns (uint256 c) {
        require(b == 0 || (c = a * b) / b == a, "ds-math-mul-overflow");
    }

    function setRatio(uint256 _ratio) public onlyAdmin {
        ratioAB = _ratio;
    }

    function getRatio() public view onlyAdmin returns (uint256) {
        return ratioAB;
    }

    function setFees(uint256 _fees) public onlyAdmin {
        swapFees = _fees;
    }

    function getFees() public view onlyAdmin returns (uint256) {
        return swapFees;
    }

    function swapA(uint256 amountA) public returns (uint256) {
        // Amount must be greater than zero
        require(amountA > 0, 'Amount of Token A must be greater than 0');
        require(swapTokenA.balanceOf(msg.sender) >= amountA, "Sender does not have enough tokens");

        uint256 exchangeA  =  uint256(_multiply(amountA, ratioAB));
        uint256 exchangeAmount = exchangeA - uint256(_multiply(exchangeA, swapFees) / 100);

        require(exchangeAmount > 0, "Exchange amount must be greater than zero");

        require(swapTokenB.balanceOf(address(this)) >  exchangeAmount, 'Exchange was not successfully completed, please retry again');

        swapTokenA.transferFrom(msg.sender, address(this), amountA);
        swapTokenB.approve(address(msg.sender), exchangeAmount);
        swapTokenB.transferFrom(address(this), address(msg.sender), exchangeAmount);

        return exchangeAmount;
    }

    function swapB(uint256 amountB) public returns (uint256) {
        // Amount must be greater than zero
        require(amountB >= ratioAB, 'Amount of Token B must be greater than the ratio');
        require(swapTokenB.balanceOf(msg.sender) >= amountB, "Sender does not have enough tokens");

        uint256 exchangeA  =  amountB / ratioAB;
        uint256 exchangeAmount = exchangeA - ((exchangeA * swapFees)* 100 );

        require(exchangeAmount > 0, "Exchange amount must be greater than zero");

        require(swapTokenA.balanceOf(address(this)) >  exchangeAmount, 'Exchange was not successfully completed, please retry again');

        swapTokenB.transferFrom(msg.sender, address(this), amountB);
        swapTokenA.approve(address(msg.sender), exchangeAmount);
        swapTokenA.transferFrom(address(this), address(msg.sender), exchangeAmount);

        return exchangeAmount;
    }

    function buyTokensA(uint256 _amount) public payable onlyAdmin {
        swapTokenA.buyTokens{value: msg.value}(_amount);
    }

    function buyTokensB(uint256 _amount) public payable onlyAdmin {
        swapTokenB.buyTokens{value:msg.value}(_amount);
    }

}