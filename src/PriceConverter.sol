// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint) {
        // Sepolia ETH / USD Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        (, int answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint(answer * 10000000000);
    }

    function getConversionRate(
        uint ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint) {
        uint ethPrice = getPrice(priceFeed);
        uint ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}