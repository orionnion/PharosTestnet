// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

contract Faroswap is Script {
    address FAROSWAP = 0x3541423f25A1Ca5C98fdBCf478405d3f0aaD1164;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address tokenIn = 0x72df0bcd7276f2dFbAc900D1CE63c272C4BCcCED;
        address tokenOut = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
        uint256 amountIn = 500000;
        uint256 minReturn = 190335468224828;
        uint256 guaranteedAmount = 130948900646374;
        address[] memory adapters = new address[](2);
        adapters[0] = 0x133dc434daaa4fDaB19f7599AB552D6Ac350c810;
        adapters[1] = 0x133dc434daaa4fDaB19f7599AB552D6Ac350c810;
        address[] memory routes = new address[](2);
        routes[0] = 0x3b6253CE8dAC4B87cF43e02DE3a2A9B02DcE1BE1;
        routes[1] = 0x2762E8EB45b6329Bb7Cc5E1BE19e1feBd39089a3;
        address[] memory swapPairs = new address[](3);
        swapPairs[0] = 0x3b6253CE8dAC4B87cF43e02DE3a2A9B02DcE1BE1;
        swapPairs[1] = 0x2762E8EB45b6329Bb7Cc5E1BE19e1feBd39089a3;
        swapPairs[2] = 0x3541423f25A1Ca5C98fdBCf478405d3f0aaD1164;
        uint256 deadline = 2;
        bytes[] memory swapData = new bytes[](2);
        swapData[
            0
        ] = hex"000000000000000000000000000000000000000000000000000000000000001e0000000000000000000000000000000000000000000000000000000000002710";
        swapData[
            1
        ] = hex"000000000000000000000000000000000000000000000000000000000000001e0000000000000000000000000000000000000000000000000000000000002710";
        bytes
            memory referralData = hex"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        uint256 timeout = block.timestamp + 5 minutes;
        uint repetition;
        while (repetition < 50) {
            (bool success, ) = FAROSWAP.call(
                abi.encodeWithSelector(
                    bytes4(0xff84aafa),
                    tokenIn,
                    tokenOut,
                    amountIn,
                    minReturn,
                    guaranteedAmount,
                    adapters,
                    routes,
                    swapPairs,
                    deadline,
                    swapData,
                    referralData,
                    timeout
                )
            );
            require(success, "mixSwap call failed");
            repetition++;
        }
        vm.stopBroadcast();
    }
}

contract FaroswapAddLiquidity is Script {
    address faroswapAddLiquidity = 0x4b177AdEd3b8bD1D5D747F91B9E853513838Cd49;
    uint repetition;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address token = 0xD4071393f8716661958F766DF660033b3d35fD29;
        address vault = 0xFf7129709eBD3485c4ED4fEf6dD923025D24e730;
        address sender = msg.sender;
        uint256 requiredAmount = 10000;
        uint256 balance = IERC20(token).balanceOf(sender);
        uint256 allowance = IERC20(token).allowance(sender, vault);
        console.log("Token balance:", balance);
        console.log("Token allowance:", allowance);
        if (balance < requiredAmount) {
            console.log("Insufficient token balance for add liquidity");
        }
        if (allowance < requiredAmount) {
            IERC20(token).approve(vault, type(uint256).max);
            console.log("Token approved for vault");
        }
        while (repetition < 50) {
            (bool success, ) = faroswapAddLiquidity.call(
                abi.encodeWithSelector(
                    bytes4(0x674d9422),
                    vault,
                    3287,
                    requiredAmount,
                    3283,
                    9990,
                    0,
                    block.timestamp + 5 minutes
                )
            );
            require(success);
            repetition++;
        }
        vm.stopBroadcast();
    }
}
