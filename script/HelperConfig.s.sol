// SPDX-License-Identifier: MIT

// 1. Deploy mocks when we are on a local anvil chain
// 2. Keep track of contract address across different chains
// Spolia ETH/USD
// Mainnet ETH/USD

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    // If we are on a local anvil, we deploy mocks
    // Otherwise, grab the existing address from the live network
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH/USD price feed address
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = get_Sepolia_Eth_Config();
        } else if (block.chainid == 0x1) {
            activeNetworkConfig = get_Mainnet_ETH_Config();
        } else {
            activeNetworkConfig = get_or_Create_Anvil_Eth_Config();
        }
    }

    function get_Sepolia_Eth_Config()
        public
        pure
        returns (NetworkConfig memory)
    {
        // prive feed Address
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function get_Mainnet_ETH_Config()
        public
        pure
        returns (NetworkConfig memory)
    {
        // prive feed Address
        NetworkConfig memory ethConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethConfig;
    }

    function get_or_Create_Anvil_Eth_Config()
        public
        returns (NetworkConfig memory)
    {
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
        // price feed address

        // 1. Deploy the mocks
        // 2. Return the mock address

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );

        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }
}
