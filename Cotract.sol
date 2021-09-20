// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './GTCToken.sol';

contract SmartContract {
    
  mapping(string => User) phoneNumberMapping;
  uint totalUsers = 0;
  GTCToken Token;
  
  struct User {
      address connectedAddress;
      string networkProvider;
      uint totalCallTime;
      uint tarrifBalance;
  }
  
  uint tarrifRatePerSec = 1; //GTC/sec
  constructor(address tokenAddress) {
        Token = GTCToken(tokenAddress);
  }
    
  function mapNumberToAddress(string memory number, address usersAddress, string memory serviceProvider) external  returns (uint)   {
      phoneNumberMapping[number] = User(usersAddress,serviceProvider,0,0);
      totalUsers++; 
      return totalUsers;
  }
  
  function isNumberConnected(string memory number) public view returns (bool){
      bytes memory number_ = bytes(number);
      require(number_.length > 0,"Phone Number is required");
      require(phoneNumberMapping[number].connectedAddress != address(0x0000000000000000000000000000000000000000),"Number not mapped yet");
      return true;
  }
  
  function getTarrifBallance(string memory number) public view returns (uint){
      bytes memory number_ = bytes(number);
      require(number_.length > 0,"Phone Number is required");
      require(phoneNumberMapping[number].connectedAddress != address(0x0000000000000000000000000000000000000000),"Number not mapped yet");
      return phoneNumberMapping[number].tarrifBalance;
  }

  function getTarrifRate() public view returns (uint){
      return tarrifRatePerSec;
  }

  function setTarrifRate(uint rate) public {
      require(rate > 0,"Tarrif Rate should be greater than 0");
      tarrifRatePerSec = rate;
  }

  function callEnded(uint time,address from) external returns (bool){
    // burn tokens for the call
    Token.burnToken(time,from);
    // update tarrif balance
    // update total call time
    // return true if call is ended
    return true;
  }
  
  function getTokenBalance() public view returns (uint) {
      return Token.getContractsBalance();
  }

}