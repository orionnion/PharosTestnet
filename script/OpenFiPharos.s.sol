// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract OpenFiPharos is Script {
    address OPEN_FI_ADDRESS = 0x11d1ca4012d94846962bca2FBD58e5A27ddcBfC5;
    // function signature: supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode)
    address[] assets = [
        0xAaF3A7F1676385883593d7Ea7ea4FcCc675EE5d6, // NVIDIA
        0x4E28826d32F1C398DED160DC16Ac6873357d048f, // WETH
        0xAaf03Cbb486201099EdD0a52E03Def18cd0c7354, // GOLD
        0x8275c526d1bCEc59a31d673929d3cE8d108fF5c7, // WBTC
        0x72df0bcd7276f2dFbAc900D1CE63c272C4BCcCED, // USDC
        0xA778b48339d3c6b4Bc5a75B37c6Ce210797076b1, // TESLA
        0xD4071393f8716661958F766DF660033b3d35fD29 // USDT
    ];
    address depositor = 0x7BDF2f4E590B5b9523D6D91b5a193AA503021381; // Change this with your own address
    uint256 amountRepetition = 0;

    function run() external {
        for (amountRepetition; amountRepetition < 8; amountRepetition++) {
            for (uint i = 0; i < assets.length; i++) {
                address currentAsset = assets[i];
                if (currentAsset == address(0)) {
                    console.log("Skip zero address");
                    continue;
                }
                vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
                IERC20Metadata erc20 = IERC20Metadata(currentAsset);
                uint256 amount = 1 * erc20.decimals();
                uint256 currentAllowance = erc20.allowance(
                    depositor,
                    OPEN_FI_ADDRESS
                );
                if (currentAllowance < amount) {
                    console.log("  -> Approving token:", currentAsset);
                    erc20.approve(OPEN_FI_ADDRESS, type(uint256).max);
                }
                (bool success, ) = OPEN_FI_ADDRESS.call(
                    abi.encodeWithSelector(
                        bytes4(0x617ba037),
                        currentAsset,
                        amount,
                        depositor,
                        0
                    )
                );
                require(success, "Deposit failed");
                vm.stopBroadcast();
            }
        }
    }
}
