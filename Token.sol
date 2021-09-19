// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GTCToken is ERC20 {
  
  mapping(string => User) phoneNumberMapping;
  uint totalUsers = 0;
  
  struct User {
      address connectedAddress;
      string networkProvider;
      uint totalCallTime;
  }
  
  modifier isContract(address addr) {
  uint size = 0;
  assembly { size := extcodesize(addr) }
  require(size == 0);
    _;
}
   
  constructor() ERC20("Global Time Coin","GTC") {
    _mint(msg.sender, 100000000 * 10**18);
    _mint(address(this), 100000000 * 10**18);
   
  }
  
  function getContractsAddres() public view returns (address){
      return address(this);
  }
  
  function getContractsBalance() public view returns (uint){
      return address(this).balance;
  }
  
  function mapNumberToAddress(string memory number, address usersAddress, string memory serviceProvider) external isContract(usersAddress) returns (uint)   {
      phoneNumberMapping[number] = User(usersAddress,serviceProvider,0);
      totalUsers++; 
      return totalUsers;
  }
  
  function isNumberConnected(string memory number) public view returns (bool){
      bytes memory number_ = bytes(number);
      require(number_.length > 0,"Phone Number is required");
      require(phoneNumberMapping[number].connectedAddress != address(0x0000000000000000000000000000000000000000),"Number not mapped yet");
      return true;
  }
  
//   function getTarrifBallance(string memory number) public view returns (uint){
//       bytes memory number_ = bytes(number);
//       require(number_.length > 0,"Phone Number is required");
//       require(phoneNumberMapping[number]);
//   }
  
}