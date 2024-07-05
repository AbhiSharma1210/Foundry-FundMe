// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {FunWithStorage} from "../../src/exampleContracts/FunWithStorage.sol";

contract FunWithStorageTest is Test {
    FunWithStorage funWithStorage;

    function setUp() external {
        funWithStorage = new FunWithStorage();
    }

    function testDo_stuff() public {
        (uint256 actualFavoriteNumber, bool actualBool) = funWithStorage.doStuff();
        assertEq(actualBool, true);
        assertEq(actualFavoriteNumber, 27);
    }
}
