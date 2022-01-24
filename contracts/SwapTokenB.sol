// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SWAPTOKENB  is ERC20{
    uint256 public tokenPrice;
    uint256 public tokensSold;

    // Declare a constructor which mints initial amount of
    // tokens supply once the contract is called
    constructor(uint256 initialSuply, uint256 _tokenPrice) ERC20("SWAPTOKENB", "SWPB"){
        tokenPrice = _tokenPrice;
        _mint(msg.sender, initialSuply * 10**decimals());
    }


    function _multiply(uint256 a, uint256 b) internal pure returns (uint256 c) {
        require(b == 0 || (c = a * b) / b == a, "ds-math-mul-overflow");
    }

    function buyTokens(uint256 numberOfTokens) external payable {
        require(msg.value >= _multiply(numberOfTokens, tokenPrice));
        require(this.balanceOf(msg.sender) >= numberOfTokens);
        require(this.transfer(msg.sender, numberOfTokens));

        tokensSold += numberOfTokens;
    }

}