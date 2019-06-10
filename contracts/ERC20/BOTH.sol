pragma solidity>=0.4.24;

import "./SampleERC20.sol" ;
import "./SampleERC20sec.sol";
// import ;


contract BOTH {
       fuzz1Token F1 = fuzz1Token(0x35eF07393b57464e93dEB59175fF72E6499450cF); // address of contract of FUZZ1TOKEN
       fuzz2Token F2 = fuzz2Token(0xBde95422681e4C3984635Af2f2F35f8c44A4ddc9); // address of contract of FUZZ2TOKEN
       
       address public owner;
       
       constructor() public payable{
           owner = msg.sender;
       }
       
       function transferTo(uint256 _amount, address to1) public{
           require(F1.balanceOf(this)>=_amount);
           require(F2.balanceOf(this)>=_amount);
           
           F1.transfer(to1, _amount);
           F2.transfer(to1, _amount);
       }
       
       function transferToSOLO(uint256 _amount, address to1, address to2) public{
           require(F1.balanceOf(this)>=_amount);
           require(F2.balanceOf(this)>=_amount);
           
           F1.transfer(to1, _amount);
           F2.transfer(to2, _amount);
       }
       
       
       function returnBalances() public view returns(uint256, uint256){
           return (F1.balanceOf(this), F2.balanceOf(this));
       }
}
