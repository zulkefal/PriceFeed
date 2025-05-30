// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "forge-std/Script.sol";
import "../src/PriceFeed.sol";

contract DeployPriceFeed is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy the PriceFeed contract
        PriceFeed priceFeed = new PriceFeed();

        vm.stopBroadcast();
    }
}
