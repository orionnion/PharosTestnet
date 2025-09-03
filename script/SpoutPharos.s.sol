// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract Spout is Script {
    address SPOUT = 0x81b33972f8bdf14fD7968aC99CAc59BcaB7f4E9A;
    uint repetition;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        while (repetition < 100) {
            (bool success, ) = SPOUT.call(
                abi.encodeWithSelector(
                    bytes4(0x28274b63),
                    2000002,
                    "LQD",
                    address(0x54b753555853ce22f66Ac8CB8e324EB607C4e4eE),
                    100000
                )
            );
            require(success, "Call failed");
            repetition++;
        }
        vm.stopBroadcast();
    }
}
