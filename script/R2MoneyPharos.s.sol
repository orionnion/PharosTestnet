// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract R2MoneySwap is Script {
    address R2_MONEY_SWAP_ADDRESS = 0x4f5b54d4AF2568cefafA73bB062e5d734b55AA05;
    address sender = 0x7BDF2f4E590B5b9523D6D91b5a193AA503021381; // Change this with your own address
    uint256 AMOUNT = 1000000;
    uint256 amountRepetition = 0;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // (bool success, ) = R2_MONEY_SWAP_ADDRESS.call(
        //     abi.encodeWithSignature("burn(address,uint256)", sender, AMOUNT)
        // );
        for (amountRepetition; amountRepetition < 50; amountRepetition++) {
            // Don't use amountRepetition too much, 50 is max
            console.log(
                "Processing burn R2USD token for attempt:",
                amountRepetition + 1
            );
            // IERC20(R2_MONEY_SWAP_ADDRESS).approve(
            //     R2_MONEY_SWAP_ADDRESS,
            //     AMOUNT
            // );
            (bool success, ) = R2_MONEY_SWAP_ADDRESS.call(
                abi.encodeWithSelector(bytes4(0x9dc29fac), sender, AMOUNT)
            );
            require(success, "Transaction failed");
        }
        vm.stopBroadcast();
    }
}

contract R2MoneySavings is Script {
    address R2_MONEY_SAVINGS_ADDRESS =
        0xF8694d25947A0097CB2cea2Fc07b071Bdf72e1f8;
    uint256 AMOUNT = 1000000;
    uint256 amountRepetition = 0;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        for (amountRepetition; amountRepetition < 50; amountRepetition++) {
            // Don't use amountRepetition too much, 50 is max
            console.log(
                "Processing swap R2USD to sR2USD for attempt:",
                amountRepetition + 1
            );
            // IERC20(R2_MONEY_SAVINGS_ADDRESS).approve(
            //     R2_MONEY_SAVINGS_ADDRESS,
            //     AMOUNT
            // );
            (bool success, ) = R2_MONEY_SAVINGS_ADDRESS.call(
                abi.encodeWithSelector(
                    bytes4(0x1a5f0f00),
                    AMOUNT,
                    0,
                    0,
                    0,
                    0,
                    0
                )
            );
            require(success, "Transaction failed");
        }
        vm.stopBroadcast();
    }
}
