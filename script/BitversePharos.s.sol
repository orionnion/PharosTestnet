// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract Bitverse is Script {
    address bitverse = 0xbf428011d76eFbfaEE35a20dD6a0cA589B539c54;
    string pair = "NVDA-USD";
    uint repetition = 0;

    struct TokenAmount {
        address token;
        uint256 amount;
    }

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        TokenAmount[] memory tokenAmounts = new TokenAmount[](1);
        tokenAmounts[0] = TokenAmount({
            token: 0xD4071393f8716661958F766DF660033b3d35fD29,
            amount: 2000000
        });
        while (repetition < 50) {
            /**
             * @notice Change call parameters below with yours. Do manual transaction first, go to https://testnet.pharosscan.xyz/ and see your transaction
             * Then, decode the calldata and pass it into below (Change all inside the abi.encodeWithSelector except for bytes4(0x35987122))
             */
            (bool success, ) = bitverse.call(
                abi.encodeWithSelector(
                    bytes4(0x35987122),
                    pair,
                    170000000,
                    0,
                    1000,
                    1,
                    100000,
                    tokenAmounts,
                    112000000000,
                    105000000000,
                    298369,
                    52149,
                    1756872647,
                    hex"8b1076a5fdb406604f0170e68dbf047afad5edfbc8ac52baa05917b9edd6ce8d58fd8a119fde15e8b44f337e7e5aa19991ac2a29dc8b97d1b597037ae6e9c2a21c",
                    0
                )
            );
            require(success, "Call failed");
            repetition++;
        }
        vm.stopBroadcast();
    }
}
