//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract DeployFallback is Script {
    function run() external returns (Fallback) {
        vm.startBroadcast();
        Fallback fallBack = new Fallback();
        vm.stopBroadcast();
        return fallBack;
    }
}
