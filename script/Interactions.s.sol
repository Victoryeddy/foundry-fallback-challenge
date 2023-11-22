//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

import {Fallback} from "../src/Fallback.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract Contribute is Script {

    //  address contractAddress = DevOpsTools.get_most_recent_deployment("Fallback", block.chainid);
    // Fallback fallBack = Fallback(payable(contractAddress));
    // fallBack.contribute{value: 0.00001 ether}();
    
    
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("Fallback", block.chainid);
        contributeETH(payable(mostRecentlyDeployed));
    }

    function contributeETH(address payable contractAddress) public {
        vm.startBroadcast();
        Fallback(contractAddress).contribute{value: 0.00001 ether}();
        vm.stopBroadcast();
    }
}

contract GetContribution is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("Fallback", block.chainid);
        contributeETH(payable(mostRecentlyDeployed));
    }

    function contributeETH(address payable contractAddress) public {
        vm.startBroadcast();
        Fallback(contractAddress).getContribution();
        vm.stopBroadcast();
    }
}
