// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./SwapTokenA.sol";
import "./SwapTokenB.sol";


contract ParaSwap {
    address payable owner;
    uint256 ratioTokenAtoB;
    bool isTokenAcheaperThanTokenB;
    uint256 swapFees;


    //Instantiate the tokens to be swapped

}