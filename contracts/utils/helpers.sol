// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Helper{
    address payable admin;
    uint256 ratioTokenAtoB;
    
    modifier onlyAdmin() {
        payable(msg.sender) == admin;
        _;
    }
    function setRatio(uint256 _ratio) public onlyAdmin {
        ratioTokenAtoB = _ratio;
    }
}



