// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
import "../lib/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import "../lib/v3-periphery/contracts/libraries/OracleLibrary.sol";

contract PriceFeed {
    /// @notice Uniswap V3 pool for fetching prices.
    IUniswapV3Pool public uniswapV3Pool;

    address constant USDT = address(0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9);
    address public baseToken;

    /// @notice base amount of particular tokens.
    uint256 public baseAmount;

    mapping(address => bool) public isOwner;

    /// @dev Emitted whenever pool address is updated
    event PoolAddressSet(address poolAddress);

    /// @dev Initializes the contract with base amount
    constructor() {
        baseAmount = 1e18;
        isOwner[msg.sender] = true;
    }

    /// @dev Calculates the price of a DOPOracle in the quote token based on a given amount of the base token
    /// @return amount of the quote token equivalent to the given base token amount.
    function getPrice() external view returns (uint256) {
        // Fetch price from slot0
        (, int24 tick, , , , , ) = uniswapV3Pool.slot0();

        uint256 amountGot = OracleLibrary.getQuoteAtTick(
            tick,
            uint128(baseAmount),
            baseToken,
            USDT
        );

        return amountGot;
    }

    ///@dev Updates the Uniswap V3 pool address for the contract.
    ///@param _poolAddress The new address of the Uniswap V3 pool contract.
    function setPoolAddress(address _poolAddress, address _baseToken) public {
        require(_poolAddress != address(0), "Pool address cannot be zero");
        require(isOwner[msg.sender], "Only owner can set pool address");
        uniswapV3Pool = IUniswapV3Pool(_poolAddress);
        baseToken = _baseToken;
        emit PoolAddressSet(_poolAddress);
    }

    function addOwner(address newOwner) public {
        require(isOwner[msg.sender], "Only owner can add new owner");
        isOwner[newOwner] = true;
    }
}
