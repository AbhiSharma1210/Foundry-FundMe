// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address most_recently_deployed) public {
        vm.startBroadcast();
        FundMe(payable(most_recently_deployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();

        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address most_recently_deployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(most_recently_deployed);
    }
}

contract WithdrawFundMe is Script {
    // uint256 constant SEND_VALUE = 0.01 ether;

    function withdrawFundMe(address most_recently_deployed) public {
        vm.startBroadcast();
        FundMe(payable(most_recently_deployed)).withdraw();
        vm.stopBroadcast();

        console.log("Withdraw FundMe balance!");
    }

    function run() external {
        address most_recently_deployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(most_recently_deployed);
    }
}
