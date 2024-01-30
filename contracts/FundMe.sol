// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
     uint256 public minimumUsd = 50 * 1e18; 

    function fund() public payable {
     //  Want to be able set a minimum fun amount in USD
     // 1. How do we send etherium to this contract
     require(getConversionRate(msg.value) >= minimumUsd, "Didnt send enough");
     // Require allows your return that gas that you spend if the function fails


    }
  function getPrice() public view returns(uint256) {
    
    //instanst ABI and Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
   AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int256 price,,,) = priceFeed.latestRoundData();

    return  uint256(price * 1e10);
  
  }

  
  function getVersion() public view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    return priceFeed.version();
  }
  function getConversionRate(uint256 ethAmount) public view returns (uint256)  {
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
    return ethAmountInUsd; 
  }

}