// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether; // 1000000000000000
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        // us ->
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function test_minimum_dollar_is_five() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function test_owner_is_msg_sender() public {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function test_price_feed_version_is_accurate() public {
        uint256 version = fundMe.getVersion();
        console.log(fundMe.getVersion());
        assertEq(version, 4);
    }

    function test_FundMe_fail_without_enough_ETH() public {
        vm.expectRevert(); // The next line should revert.abi
        fundMe.fund();
    }

    function test_fund_updates_funded_dataStructure() public {
        vm.prank(USER); // The next TnX will be sent by USER

        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function test_adds_funders_to_array_of_funders() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function test_only_owner_can_withraw() public funded {
        vm.prank(USER);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function test_withDraw_with_singleFunder() public funded {
        // Arrange
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;
        assertEq(endingFundMeBalance, 0);
        assertEq(
            startingFundMeBalance + startingOwnerBalance,
            endingOwnerBalance
        );
    }

    function test_withDraw_from_multipleFunders_Cheaper() public funded {
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            // vm.prank new address
            // vm.deal new address

            hoax(address(i), SEND_VALUE); // Does the function of both prank and deal
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingFundMeBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperWithdraw();
        vm.stopPrank();

        // Assert
        assert(address(fundMe).balance == 0);
        assert(
            startingFundMeBalance + endingFundMeBalance ==
                fundMe.getOwner().balance
        );
    }
}
