// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GTCToken is ERC20 {
  
	address public crowdsaleAddress;
	address public owner;
	uint256 public ICOEndTime;

	modifier onlyCrowdsale {
		require(msg.sender == crowdsaleAddress);
		_;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}

	modifier afterCrowdsale {
		require(block.timestamp > ICOEndTime || msg.sender == crowdsaleAddress);
		_;
	}
	
  constructor() ERC20("Global Time Coin","GTC") {
    _mint(msg.sender, 100000000 * 10**18);
    _mint(address(this), 100000000 * 10**18);
    owner = msg.sender;
  }
  
  function burnToken(uint amount, address from) external{
      super._burn(from, amount);
  }
  
  function getContractsAddres() public view returns (address){
      return address(this);
  }
  
  function getContractsBalance() public view returns (uint){
      return address(this).balance;
  }
  
  	function setCrowdsale(address _crowdsaleAddress) public onlyOwner {
		require(_crowdsaleAddress != address(0));
		crowdsaleAddress = _crowdsaleAddress;
	}

	function buyTokens(address _receiver, uint256 _amount) public onlyCrowdsale {
		require(_receiver != address(0));
		require(_amount > 0);
		transfer(_receiver, _amount);
	}

     function emergencyExtract() external onlyOwner {
         address contractAddress = payable(address(this));
         address payable contractOwner = payable(address(owner));
         contractOwner.transfer(contractAddress.balance);
    }
    
}