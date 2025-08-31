# Pharos Scripts

This repository contains Solidity scripts for interacting with various DeFi contracts on the Pharos platform. The scripts are designed to automate token operations such as supply, burn, and swap using Foundry's scripting environment.

## Scripts Overview

### 1. OpenFiPharos.s.sol

Automates supplying multiple ERC20 tokens to the OpenFi protocol contract.

- **Contract:** `OpenFiPharos`
- **Target Address:** `0x11d1ca4012d94846962bca2FBD58e5A27ddcBfC5`
- **Assets Supported:** NVIDIA, GOLD, USDC, TESLA, USDT (addresses hardcoded)
- **Operation:**
  - For each asset, checks allowance and approves if needed.
  - Supplies a fixed amount of each token to OpenFi in a loop.
  - Uses `supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode)` function signature.

### 2. R2MoneyPharos.s.sol

Contains two scripts for interacting with R2Money contracts:

#### a. R2MoneySwap

- **Contract:** `R2MoneySwap`
- **Target Address:** `0x4f5b54d4AF2568cefafA73bB062e5d734b55AA05`
- **Operation:**
  - Calls the `burn(address,uint256)` function to burn R2USD tokens from a specified address.
  - Repeats the burn operation up to 50 times.

#### b. R2MoneySavings

- **Contract:** `R2MoneySavings`
- **Target Address:** `0xF8694d25947A0097CB2cea2Fc07b071Bdf72e1f8`
- **Operation:**
  - Calls a swap function to convert R2USD to sR2USD.
  - Repeats the swap operation up to 50 times.

## Prerequisites

- [Foundry](https://book.getfoundry.sh/) installed (`forge`, `cast`)
- Sufficient token balances and allowances for the operations
- Set your private key in the environment variable `PRIVATE_KEY`

## Usage

1. **Configure your environment:**

   - Export your private key:
     ```bash
     export PRIVATE_KEY=<your_private_key>
     ```
   - Ensure your wallet has enough tokens and gas for transactions.

2. **Run a script:**
   - To run the OpenFiPharos script:
     ```bash
     forge script script/OpenFiPharos.s.sol:OpenFiPharos --broadcast -vvv
     ```
   - To run the R2MoneySwap script:
     ```bash
     forge script script/R2MoneyPharos.s.sol:R2MoneySwap --broadcast -vvv
     ```
   - To run the R2MoneySavings script:
     ```bash
     forge script script/R2MoneyPharos.s.sol:R2MoneySavings --broadcast -vvv
     ```

## Notes

- Scripts use hardcoded addresses for assets and contracts. Update them as needed for your environment.
- The scripts perform multiple repetitions for each operation. Adjust the repetition count in the code if needed.
- Ensure you have sufficient token balances and permissions before running the scripts.
- Errors related to RPC or contract logic will be shown in the terminal output.

## Troubleshooting

- If you encounter RPC errors (e.g., service busy), try switching to a different RPC provider or reducing repetitions.
- For contract reverts, check token balances, allowances, and contract restrictions.

## License

MIT
