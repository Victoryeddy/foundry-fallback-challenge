//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {DeployFallback} from "../script/DeployFallback.s.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback fallBack;
    address public BOB = makeAddr("Bob");
    address public ALICE = makeAddr("alice");
    uint256 constant ETHAMOUNT = 0.01 ether;
    uint256 constant ALICEAMOUNT = 0.0001 ether;
    uint256 constant BOBAMOUNT = 0.00001 ether;

    function setUp() public {
        DeployFallback deployFallback = new DeployFallback();
        (fallBack) = deployFallback.run();
        vm.deal(BOB, ETHAMOUNT + 1 ether);
        vm.deal(ALICE, ETHAMOUNT + 1 ether);
    }

    function testOwnerIsMsgSender() public view {
        // Arrange
        address sender = msg.sender;
        address owner = fallBack.owner();
        console.log(sender, owner);
        // Assert
        assert(sender == owner);
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(BOB);
        vm.expectRevert();
        fallBack.withdraw();
    }

    function testPeopleCannotPayAnyAmountThanRequired() public {
        uint160 numberOfFunders = 5;
        uint160 startingFunderIndex = 1;
        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i), ETHAMOUNT);
            vm.expectRevert();
            fallBack.contribute{value: ETHAMOUNT}();
        }
    }

    function testUsersContributionIsCorrect() public {
        uint256 expectedContribution = BOBAMOUNT;
        vm.prank(BOB);
        fallBack.contribute{value: BOBAMOUNT}();
        console.log(fallBack.getTotalAmount());
        console.log(expectedContribution);
        assertEq(fallBack.getTotalAmount() , expectedContribution);
    }

    function testFallBackInitialBalanceIsZero() public {
        assertEq(fallBack.getTotalAmount(), 0);
    }
}
