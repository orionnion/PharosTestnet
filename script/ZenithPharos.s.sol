// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

contract ZenithSwap is Script {
    address zenithSwap = 0x1A4DE519154Ae51200b0Ad7c90F7faC75547888a;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address token = 0x72df0bcd7276f2dFbAc900D1CE63c272C4BCcCED;
        address router = 0x3B00fab338E936c64C82F3d1C581de0E9b966201;
        address sender = msg.sender;
        uint256 requiredAmount = 100000;
        uint256 balance = IERC20(token).balanceOf(sender);
        uint256 allowance = IERC20(token).allowance(sender, router);
        console.log("Token balance:", balance);
        console.log("Token allowance:", allowance);
        if (balance < requiredAmount) {
            console.log("Insufficient token balance for multicall");
        }
        if (allowance < requiredAmount) {
            IERC20(token).approve(router, type(uint256).max);
            console.log("Token approved for router");
        }
        uint256 deadline = block.timestamp + 5 minutes;
        bytes[] memory calls = new bytes[](1);
        uint repetition = 0;
        calls[
            0
        ] = hex"04e45aaf00000000000000000000000072df0bcd7276f2dfbac900d1ce63c272c4bccced000000000000000000000000d4071393f8716661958f766df660033b3d35fd2900000000000000000000000000000000000000000000000000000000000027100000000000000000000000007bdf2f4e590b5b9523d6d91b5a193aa50302138100000000000000000000000000000000000000000000000000000000000186a0000000000000000000000000000000000000000000000000000000000000c8370000000000000000000000000000000000000000000000000000000000000000";
        while (repetition < 50) {
            (bool success, ) = zenithSwap.call(
                abi.encodeWithSelector(bytes4(0x5ae401dc), deadline, calls)
            );
            require(success, "multicall failed");
            repetition++;
        }
        vm.stopBroadcast();
    }
}

contract ZenithAddLiquidity is Script {
    address zenithAddLiquidity = 0xF8a1D4FF0f9b9Af7CE58E1fc1833688F3BFd6115;
    uint repetition = 0;

    struct MintParams {
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        address recipient;
        uint256 deadline;
    }

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MintParams memory params = MintParams({
            token0: 0x72df0bcd7276f2dFbAc900D1CE63c272C4BCcCED,
            token1: 0xD4071393f8716661958F766DF660033b3d35fD29,
            fee: 500,
            tickLower: -887270,
            tickUpper: 887270,
            amount0Desired: 18531,
            amount1Desired: 10000,
            amount0Min: 18084,
            amount1Min: 9746,
            recipient: 0x7BDF2f4E590B5b9523D6D91b5a193AA503021381,
            deadline: 1756881080
        });
        while (repetition < 50) {
            (bool success, ) = zenithAddLiquidity.call(
                abi.encodeWithSelector(bytes4(0x88316456), params)
            );
            require(success, "mint call failed");
        }
        vm.stopBroadcast();
    }
}
