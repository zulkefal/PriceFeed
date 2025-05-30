
# PriceFeed

A simple Uniswap V3 price oracle contract for fetching token prices on-chain.

## Overview

The `PriceFeed` contract allows you to fetch the price of a specified base token in USDT using a Uniswap V3 pool.

## Features

- Fetches price from a Uniswap V3 pool using the latest tick.
- Owner management (multiple owners supported).
- Allows updating the pool and base token addresses.

## Usage

### Deployment

Deploy the contract using Foundry or your preferred tool. After deployment, set the Uniswap V3 pool and base token addresses:

```solidity
priceFeed.setPoolAddress(_poolAddress, _baseToken);
```

### Fetching Price

Call the `getPrice()` function to get the price of the base token in USDT (for the configured base amount):

```solidity
uint256 price = priceFeed.getPrice();
```

### Owner Management

- Add a new owner:
    ```solidity
    priceFeed.addOwner(newOwnerAddress);
    ```

- Only owners can update the pool address or add new owners.

## Constructor

- Sets the `baseAmount` to `1e6` (1,000,000 units, e.g., for 6-decimal tokens).
- The deployer is set as the initial owner.

## Events

- `PoolAddressSet(address poolAddress)`: Emitted when the pool address is updated.

## Security

- Only owners can update the pool address or add new owners.
- Make sure to use trusted Uniswap V3 pool addresses.

## License

MIT

---

**Note:**  
- This contract uses Uniswap V3 Core and Periphery libraries.  
- The USDT address is hardcoded for Arbitrum: `0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9`.  
- Update the USDT address if deploying to a different network.

** Deployement Command ***

forge script --chain arbitrum script/DeployPriceFeed.s.sol:DeployPriceFeed --rpc-url $HOLESKY_RPC_URL --broadcast --verify