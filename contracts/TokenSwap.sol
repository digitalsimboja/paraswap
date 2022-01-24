// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./SwapTokenA.sol";
import "./SwapTokenB.sol";
import "./utils/helpers.sol";


contract ParaSwap {
    bool isTokenAcheaperThanTokenB;
    uint256 swapFees;

    //Instantiate the tokens to be swapped
    SWAPTOKENA public swpatokenA;
    SWAPTOKENB public swpatokenB;

    constructor(address _swaptokenA, address _swaptokenB) {
        admin = payable(msg.sender);
        swpatokenA = SWAPTOKENA(_swaptokenA);
        swpatokenB = SWAPTOKENB(_swaptokenB);
        swpatokenA.approve(address(this), swpatokenA.totalSupply());
        swpatokenB.approve(address(this), swpatokenB.totalSupply());
    }

}