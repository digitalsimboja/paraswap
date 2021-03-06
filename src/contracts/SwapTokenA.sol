// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SWAPTOKENA  is ERC20{
   
    uint256 public tokenPrice;
    uint256 public tokensSold;

    // Declare a constructor which mints initial amount of
    // tokens supply once the contract is called
    constructor(uint256 initialSuply, uint256 _tokenPrice) ERC20("SWAPTOKENA", "SWPA"){
        tokenPrice = _tokenPrice;
        _mint(address(this), initialSuply * 10**decimals());
    }


    function _multiply(uint256 a, uint256 b) internal pure returns (uint256 c) {
        require(b == 0 || (c = a * b) / b == a, "ds-math-mul-overflow");
    }

    function buyTokens(uint256 numberOfTokens) external payable {
        require(msg.value >= _multiply(numberOfTokens, tokenPrice));
        require(this.balanceOf(address(this)) >= numberOfTokens);
        require(this.transfer(msg.sender, numberOfTokens));

        tokensSold += numberOfTokens;
    }

}