// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0; 
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract transfer {
    using SafeMathChainlink for uint256;
    address payable public owner;
    uint256 public balance;

    constructor() public { //will be executed whenever the contract is deployed
        owner = 0x31B98D14007bDEe637298086988A0bBd31184523;
    }
    function fund() public payable{
        balance += msg.value/10**16;
    }
    function withdraw(uint256 _usdAmount) payable public {
        (,int256 answer,,,) = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e).latestRoundData();
        require(balance>_usdAmount * 1000000/uint256(answer/10**4));
        owner.transfer(_usdAmount * 10**22/uint256(answer/10**4)); 
    }

}
